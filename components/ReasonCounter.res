type action =
  | Add
  | Min

type state = {count: int}

let counterReducer = (state, action) =>
  switch action {
  | Add => {count: state.count + 1}
  | Min => {count: state.count - 1}
  }

@react.component
let make = () => {
  let (state, dispatch) = React.useReducer(counterReducer, {count: 0})

  let countMsg = "Count: " ++ string_of_int(state.count)
  <span>
    <Button onClick={_ => dispatch(Min)}> {React.string("-")} </Button>
    <strong className="RCounter_counter"> {React.string(countMsg)} </strong>
    <Button onClick={_ => dispatch(Add)}> {React.string("+")} </Button>
  </span>
}

let default = make
