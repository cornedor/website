@react.component
let make = () => {
  let (heightPx, setHeightPx) = React.useState(_ => 0)

  let handleResize = _ => {
    setHeightPx(_ => Webapi.Dom.Window.innerHeight(Webapi.Dom.window))
  }

  React.useEffect(() => {
    Webapi.Dom.Window.addEventListener("resize", handleResize, Webapi.Dom.window)

    let _ = Js.Global.setTimeout(
      () => setHeightPx(_ => Webapi.Dom.Window.innerHeight(Webapi.Dom.window)),
      100,
    )

    Some(() => Webapi.Dom.Window.removeEventListener("resize", handleResize, Webapi.Dom.window))
  })
  <div>
    <p className="heightTest">
      <span>
        {React.string("Look at how this part resizes: " ++ string_of_int(heightPx) ++ "px")}
      </span>
    </p>
    <p className="heightTestSpacer"> {React.string("Scroll down")} </p>
  </div>
}

let default = make
