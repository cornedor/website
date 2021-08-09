@react.component
let make = () => {
  let (heightPx, setHeightPx) = React.useState(_ => 0)
  let (divHeightPx, setDivHeightPx) = React.useState(_ => 0)
  let divRef = React.useRef(Js.Nullable.null)

  let handleResize = _ => {
    setHeightPx(_ => Webapi.Dom.Window.innerHeight(Webapi.Dom.window))
  }

  React.useEffect(() => {
    Webapi.Dom.Window.addEventListener("resize", handleResize, Webapi.Dom.window)

    let _ = Js.Global.setTimeout(() => {
      setHeightPx(_ => Webapi.Dom.Window.innerHeight(Webapi.Dom.window))

      divRef.current
      ->Js.Nullable.toOption
      ->Belt.Option.map(ref => setDivHeightPx(_ => Webapi.Dom.Element.clientHeight(ref)))
      ->ignore
    }, 100)

    Some(() => Webapi.Dom.Window.removeEventListener("resize", handleResize, Webapi.Dom.window))
  })
  <div>
    <div className="heightTest" ref={ReactDOM.Ref.domRef(divRef)}>
      <span>
        {React.string("Window height: " ++ string_of_int(heightPx) ++ "px")}
        <br />
        {React.string("Container height: " ++ string_of_int(divHeightPx) ++ "px")}
      </span>
    </div>
    <div className="heightTestFixedTop"> {React.string("Top")} </div>
    <div className="heightTestFixedBottom"> {React.string("Bottom")} </div>
    <p className="heightTestSpacer"> {React.string("Scroll down")} </p>
  </div>
}

let default = make
