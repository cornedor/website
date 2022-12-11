let rec chunk = (array, length) => {
  let part = Belt.Array.slice(array, ~offset=0, ~len=length)
  let rest = Belt.Array.sliceToEnd(array, length)
  switch rest {
  | [] => list{part}
  | _ => list{part, ...chunk(rest, length)}
  }
}

let badgePrioInGroup = (group: array<array<string>>) => {
  let leader = Belt.Array.get(group, 0)
  let second = Belt.Array.get(group, 1)
  let third = Belt.Array.get(group, 2)

  switch (leader, second, third) {
  | (Some(leader), Some(second), Some(third)) =>
    Belt.Array.getBy(leader, token => {
      let s = Belt.Array.getBy(second, t => token === t)
      let t = Belt.Array.getBy(third, t => token === t)
      switch (s, t) {
      | (Some(_), Some(_)) => true
      | (_, _) => false
      }
    })->DayThree.getPrioForToken
  | (_, _, _) => 0
  }
}

let rec calculateTotalPrioForBadges = groups => {
  switch groups {
  | list{} => 0
  | list{group, ...rest} => badgePrioInGroup(group) + calculateTotalPrioForBadges(rest)
  }
}

let getElfGroups = () => {
  Js.String2.split(DayThreeInput.data, "\n")
  ->Belt.Array.map(Js.String.split(""))
  ->chunk(3)
  ->calculateTotalPrioForBadges
}
