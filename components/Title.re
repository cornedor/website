module Styles = {
  open Css;

  let title =
    style([
      fontSize(px(32)),
      fontWeight(normal),
      textAlign(center),
      padding3(~top=px(0), ~h=px(0), ~bottom=px(20)),
      margin(px(0)),
      unsafe("fontFamily", "var(--font-title)"),
    ]);
};

[@react.component]
let make = (~children) => <h1 className=Styles.title> children </h1>;

[@genType]
let default = make;