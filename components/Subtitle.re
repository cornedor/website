module Styles = {
  open Css;

  let title =
    style([
      fontSize(px(24)),
      fontWeight(normal),
      padding3(~top=px(26), ~h=px(0), ~bottom=px(10)),
      margin(px(0)),
      unsafe("fontFamily", "var(--font-body)"),
    ]);
};

[@react.component]
let make = (~children) => <h2 className=Styles.title> children </h2>;

[@genType]
let default = make;