type price = {"price": float, "readingDate": string}

type marketData = {
  "prices": array<price>,
  "intervalType": int,
  "average": float,
  "fromDate": string,
  "tillDate": string,
}

let printPrice = value => {
  Intl.NumberFormat.Currency.make(~value, ~locale=Some("nl"), ~currency="EUR", ())
}

let printDate = date => {
  Intl.DateTime.make(
    ~locale=Some("sv"),
    ~date,
    ~options=Intl.DateTime.Options.make(~timeStyle=Some(#short), ()),
    (),
  )
}

@react.component
let make = (~marketData: Js.Nullable.t<marketData>, ~incorrectJson) => {
  switch Js.Nullable.toOption(marketData) {
  | Some(marketData) => {
      let max = Belt.Array.reduce(marketData["prices"], 0.0, (acc, price) =>
        max(acc, price["price"])
      )

      let prices = Belt.Array.map(marketData["prices"], price => {
        let height = price["price"] /. max *. 100.0
        let date = Js.Date.fromString(price["readingDate"])
        let nowHour = Js.Date.getHours(Js.Date.make())
        let entryHour = Js.Date.getHours(date)
        let nowDay = Js.Date.getDate(Js.Date.make())
        let entryDay = Js.Date.getDate(date)
        let isTomorrow = entryDay > nowDay
        let isPast = entryHour < nowHour && entryDay <= nowDay
        let diff = Belt.Float.toString(entryHour -. nowHour +. (isTomorrow ? 24.0 : 0.0))

        <div className={"marketdata-entry" ++ (isPast ? " marketdata-entry-past" : "")}>
          <div
            className="marketdata-bar"
            style={ReactDOM.Style.make(~height=`${Belt.Float.toString(height)}%`, ())}
          />
          <div className="marketdata-price"> {React.string(printPrice(price["price"]))} </div>
          <div className="marketdata-date"> {React.string(printDate(date) ++ ` +${diff}`)} </div>
        </div>
      })

      <div>
        <Next.Head>
          <link href="/marketdata-manifest.json" rel="manifest" />
        </Next.Head>
        <div className="marketdata"> {React.array(prices)} </div>
      </div>
    }

  | None => {
      Js.log(incorrectJson)
      <div>
        <div> {React.string("No market data")} </div>
      </div>
    }
  }
}

let default = make

let parseMarketData = json => {
  open JsonCombinators.Json.Decode

  let price = object(field =>
    {
      "price": field.required(. "price", JsonCombinators.Json.Decode.float),
      "readingDate": field.required(. "readingDate", string),
    }
  )

  let marketData = object(field =>
    {
      "prices": field.required(. "Prices", array(price)),
      "intervalType": field.required(. "intervalType", int),
      "average": field.required(. "average", JsonCombinators.Json.Decode.float),
      "fromDate": field.required(. "fromDate", string),
      "tillDate": field.required(. "tillDate", string),
    }
  )

  json->JsonCombinators.Json.decode(marketData)
}

let getServerSideProps = () => {
  open Fetch

  let base = URL.make("https://api.energyzero.nl/v1/energyprices")

  let now = Js.Date.make()

  let from = Js.Date.makeWithYMDHMS(
    ~year=Js.Date.getFullYear(now),
    ~month=Js.Date.getMonth(now),
    ~date=Js.Date.getDate(now),
    ~hours=0.0,
    ~minutes=0.0,
    ~seconds=0.0,
    (),
  )
  let to = Js.Date.makeWithYMDHMS(
    ~year=Js.Date.getFullYear(now),
    ~month=Js.Date.getMonth(now),
    ~date=Js.Date.getDate(now) +. 2.0,
    ~hours=0.0,
    ~minutes=0.0,
    ~seconds=0.0,
    (),
  )

  let searchParams = URLSearchParams.makeWithObject({
    "fromDate": Js.Date.toISOString(from),
    "tillDate": Js.Date.toISOString(to),
    "interval": 4,
    "usageType": 1,
    "inclBtw": true,
  })

  let url = URL.toString(base) ++ "?" ++ URLSearchParams.toString(searchParams)

  // let url = "http://localhost:3000/testdata.json"

  let data =
    fetch(
      url,
      {
        method: #GET,
        headers: Headers.fromObject({
          "Content-Type": "application/json",
        }),
      },
    )
    ->Promise.then(Response.json)
    ->Promise.then(d => {
      Promise.resolve(
        switch parseMarketData(d) {
        | Ok(d) => {
            "props": {
              "marketData": Js.Nullable.return(d),
              "incorrectJson": Js.Nullable.null,
            },
          }
        | e => {
            "props": {
              "marketData": Js.Nullable.null,
              "incorrectJson": Js.Nullable.return(e),
            },
          }
        },
      )
    })

  data
}
