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
