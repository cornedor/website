@module("./plausible.ts")
external plausible: string => unit = "plausible"

type revenue = {
  currency: string,
  amount: float,
}

type options<'a> = {
  callback?: unit => unit,
  props?: 'a,
  revenue?: revenue,
}

@module("./plausible.ts")
external plausibleWithOptions: (string, options<'a>) => unit = "plausible"
