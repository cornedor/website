type price = {"price": float, "readingDate": string}

type marketData = {
  "prices": array<price>,
  "intervalType": int,
  "average": float,
  "fromDate": string,
  "tillDate": string,
}

let getServerSideProps: unit => Promise.t<{
  "props": {
    "incorrectJson": Js.Nullable.t<
      result<
        {
          "average": float,
          "fromDate": string,
          "intervalType": int,
          "prices": array<{
            "price": float,
            "readingDate": string,
          }>,
          "tillDate": string,
        },
        string,
      >,
    >,
    "marketData": Js.Nullable.t<{
      "average": float,
      "fromDate": string,
      "intervalType": int,
      "prices": array<{
        "price": float,
        "readingDate": string,
      }>,
      "tillDate": string,
    }>,
  },
}>

let default: {"incorrectJson": 'a, "marketData": Js.Nullable.t<marketData>} => React.element
