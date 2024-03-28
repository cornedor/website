@val external localStorageSetItem: (string, string) => unit = "localStorage.setItem"
@val external getLightOrDarkMode: unit => string = "global.getLightOrDarkMode"
@val external updateDarkModeProperties: unit => unit = "global.updateDarkModeProperties"

let handleLightSwitchClick = _ => {
  let currentMode: string = getLightOrDarkMode()

  localStorageSetItem(
    "color-mode",
    switch currentMode {
    | "dark" => "light"
    | _ => "dark"
    },
  )

  let _ = %raw(`window?.plausible('Toggle Light', { props: { color: localStorage.getItem('color-mode') } })`)

  updateDarkModeProperties()
}

@react.component
let make = () => {
  <button className="lightSwitch" ariaLabel="Switch light mode" onClick=handleLightSwitchClick>
    <div className="lightSwitchIcons">
      <MoonIcon />
      <SunIcon />
    </div>
  </button>
}

let default = make
