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
    className="lightSwitch"
    ariaLabel="Switch light mode"
    onClick=handleLightSwitchClick>
    <div className="lightSwitchIcons"> <MoonIcon /> <SunIcon /> </div>
  </button>;
};

[@typeGen]
let default = make;
