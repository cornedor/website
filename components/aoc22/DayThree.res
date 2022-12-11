let lineToRucksack = line => {
  let length = Js.String2.length(line) / 2
  let sackOne = Js.String2.slice(line, ~from=0, ~to_=length)->Js.String2.split("")
  let sackTwo = Js.String2.sliceToEnd(line, ~from=length)->Js.String2.split("")

  (sackOne, sackTwo)
}

let tokensToRucksacks = tokens => {
  Js.String2.split(tokens, "\n")->Belt.Array.map(lineToRucksack)
}

let findDoublesInRucksack = ((sackOne, sackTwo)) => {
  Belt.Array.getBy(sackOne, item => {
    Belt.Array.some(sackTwo, other => other === item)
  })
}

let getPrioForToken = token => {
  switch token {
  | None => 0
  | Some(token) => {
      let result = Belt.Array.getBy(DayThreeInput.prios, ((t, _p)) => t === token)

      switch result {
      | Some((_, prio)) => prio
      | None => 0
      }
    }
  }
}

let getAllDoublesInRucksacks = () => {
  let rucksacks = tokensToRucksacks(DayThreeInput.data)

  Belt.Array.map(rucksacks, findDoublesInRucksack)
  ->Belt.Array.map(getPrioForToken)
  ->Belt.Array.reduce(0, \"+")
}
