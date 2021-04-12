@react.component
let make = () => {
  <div>
    <p> {React.string("This is a page completly written with ReasonML.")} </p> <ReasonCounter />
  </div>
}

let default = make
