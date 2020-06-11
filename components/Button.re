module Styles = {
  /* Open the Css module, so we can access the style properties below without prefixing them with Css. */
  open Css;

  let button =
    style([
      unsafe("backgroundColor", "var(--color-primary)"),
      borderStyle(none),
      padding2(~v=px(5), ~h=px(10)),
      boxShadow(Shadow.box(~y=px(3), ~blur=px(5), rgba(0, 0, 0, 0.3))),
      cursor(pointer),
      fontSize(inherit_),
      hover([opacity(0.8)]),
    ]);
};

[@react.component]
let make = (~children, ~onClick=?) => {
  <button ?onClick className=Styles.button> children </button>;
};

let default = make;