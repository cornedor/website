@react.component
let make = (~children) => <h1 className="title"> children </h1>;

@genType
let default = make;