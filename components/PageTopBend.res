@react.component
let make = (~className="") =>
  <svg
    width="1000"
    height="100"
    viewBox="0 0 1000 100"
    fill="none"
    preserveAspectRatio="none"
    className>
    <path d="M 0 100 C 300 -30, 700 -30, 1000 100" fill="currentColor" />
  </svg>;

@genType
let default = make;