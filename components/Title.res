@react.component
let make = (~children: option<React.element>=?) => <h1 className="title">
  {switch children {
    | Some(element) => element
    | None => React.string("Title Undefined")
    }}
</h1>

export default = make
