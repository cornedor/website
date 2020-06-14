module Styles = {
  open Css;

  let lightSwitchIcons =
    style([
      display(grid),
      gridTemplateRows([fr(1.), fr(1.)]),
      gridGap(px(10)),
      width(em(1.)),
      transition(
        ~duration=320,
        ~timingFunction=cubicBezier(0.445, 0.05, 0.55, 0.95),
        "transform",
      ),
      unsafe("transform", "translateY(var(--light-switch-icon-start-pos))"),
    ]);

  let lightSwitch =
    style([
      padding(px(10)),
      marginLeft(px(16)),
      background(none),
      borderStyle(none),
      fontSize(px(24)),
      cursor(pointer),
      overflow(hidden),
      boxSizing(contentBox),
      height(px(24)),
      unsafe("color", "var(--color-primary)"),
      hover([
        selector(
          "." ++ lightSwitchIcons,
          [
            unsafe(
              "transform",
              "translateY(var(--light-switch-icon-end-pos))",
            ),
          ],
        ),
      ]),
    ]);
};

[@bs.val] [@bs.scope "localStorage"]
external localStorageSetItem: (string, string) => unit = "setItem";

let handleLightSwitchClick = _ => {
  let currentMode: string = [%bs.raw {| global.getLightOrDarkMode() |}];
  localStorageSetItem(
    "color-mode",
    switch (currentMode) {
    | "dark" => "light"
    | _ => "dark"
    },
  );

  %bs.raw
  {| global.updateDarkModeProperties() |};
};

[@react.component]
let make = () => {
  <button
    className=Styles.lightSwitch
    ariaLabel="Switch light mode"
    onClick=handleLightSwitchClick>
    <div className=Styles.lightSwitchIcons> <MoonIcon /> <SunIcon /> </div>
  </button>;
};

[@typeGen]
let default = make;