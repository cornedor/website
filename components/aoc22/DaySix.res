// type lastFour = array<string>

let rec findMarker = (
  line: string,
  lastFour: option<array<string>>,
  cursor: int,
  markerLength: int,
) => {
  let exploded = Js.String2.split(line, "")
  switch (lastFour, exploded) {
  | (None, exploded) if Belt.Array.length(exploded) > markerLength - 1 => {
      let lastFour = Some(Belt.Array.slice(exploded, ~offset=0, ~len=markerLength))

      switch lastFour {
      | Some(_) => findMarker(line, lastFour, markerLength, markerLength)
      | _ => -1
      }
    }

  | (Some(lastFour), exploded) => {
      let lastContainsDoubles = Belt.Array.some(lastFour, c =>
        Belt.Array.length(Belt.Array.keep(lastFour, b => b == c)) > 1
      )
      let endReached = Belt.Array.length(lastFour) != markerLength

      switch (lastContainsDoubles, endReached) {
      | (false, _) => cursor
      | (_, true) => -1
      | (true, _) => {
          let offset = markerLength - 1
          let currentFour = Belt.Array.slice(exploded, ~offset=cursor - offset, ~len=markerLength)
          findMarker(line, Some(currentFour), cursor + 1, markerLength)
        }
      }
    }

  | (None, _) => -1
  }
}

let main = () => {
  (findMarker(DaySixData.data, None, 0, 4), findMarker(DaySixData.data, None, 0, 14))
}

exception Incorrect_Result
if findMarker("mjqjpqmgbljsphdztnvjfqwrcgsmlb", None, 0, 4) != 7 {
  raise(Incorrect_Result)
}
if findMarker("bvwbjplbgvbhsrlpgdmjqwftvncz", None, 0, 4) != 5 {
  raise(Incorrect_Result)
}
if findMarker("nppdvjthqldpwncqszvftbrmjlhg", None, 0, 4) != 6 {
  raise(Incorrect_Result)
}
if findMarker("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", None, 0, 4) != 10 {
  raise(Incorrect_Result)
}
if findMarker("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", None, 0, 4) != 11 {
  raise(Incorrect_Result)
}

// Part 2 tests
if findMarker("mjqjpqmgbljsphdztnvjfqwrcgsmlb", None, 0, 14) != 19 {
  raise(Incorrect_Result)
}
if findMarker("bvwbjplbgvbhsrlpgdmjqwftvncz", None, 0, 14) != 23 {
  raise(Incorrect_Result)
}
if findMarker("nppdvjthqldpwncqszvftbrmjlhg", None, 0, 14) != 23 {
  raise(Incorrect_Result)
}
if findMarker("nznrnfrfntjfmvfwmzdfjlvtqnbhcprsg", None, 0, 14) != 29 {
  raise(Incorrect_Result)
}
if findMarker("zcfzfwzzqfrljwzlrfnpqdbhtmscgvjw", None, 0, 14) != 26 {
  raise(Incorrect_Result)
}
