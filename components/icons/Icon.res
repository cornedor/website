type iconIds = [#repeat | #cornerUpLeft | #globe | #unlock | #lock | #envelope]

@react.component
let make = (~className="", ~id: iconIds) =>
  <svg className width="1em" height="1em" ariaHidden={true}>
    <use xlinkHref={"#icon-" ++ (id :> string)} />
  </svg>
