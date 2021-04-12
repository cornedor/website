@react.component
let make = (~children, ~onClick=?) => {
  <button ?onClick className="button"> children </button>
}

let default = make
