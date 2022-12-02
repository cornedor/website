let getElfCallories = () => {
  let data =
    DayOneInput.data
    |> Js.String.split("\n\n")
    |> Js.Array.map(elf => {
      elf
      |> Js.String.split("\n")
      |> Js.Array.map(item => {
        let value = Belt.Int.fromString(item)
        switch value {
        | Some(v) => v
        | None => 0
        }
      })
      |> Js.Array.reduce(\"+", 0)
    })
    |> Js.Array.sortInPlaceWith((a, b) => b - a)

  data
}

let getMostCalloriesElf = () => {
  getElfCallories()[0]
}

let getThreeMostCalloriesElf = () => {
  getElfCallories()[0] + getElfCallories()[1] + getElfCallories()[2]
}
