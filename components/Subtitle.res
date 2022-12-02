@react.component
let make = (~children: option<React.element>=?) =>
  <h2 className="subtitle">
    {switch children {
    | Some(element) => element
    | None => React.string("Subtitle Undefined")
    }}
  </h2>

let default = make
