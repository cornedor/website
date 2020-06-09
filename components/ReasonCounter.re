type action =
  | Add
  | Min;

type state = {count: int};

let counterReducer = (state, action) =>
  switch (action) {
  | Add => {count: state.count + 1}
  | Min => {count: state.count - 1}
  };

module Styles = {
  open Css;

  let counter =
    style([
      background(hex("ddd")),
      display(inlineBlock),
      padding2(~v=px(5), ~h=px(10)),
    ]);
};

[@react.component]
let make = () => {
  let (state, dispatch) = React.useReducer(counterReducer, {count: 0});

  let countMsg = "Count: " ++ string_of_int(state.count);
  <div>
    <Button onClick={_ => dispatch(Min)}> {ReasonReact.string("-")} </Button>
    <strong className=Styles.counter> {ReasonReact.string(countMsg)} </strong>
    <Button onClick={_ => dispatch(Add)}> {ReasonReact.string("+")} </Button>
  </div>;
};

let default = make;
