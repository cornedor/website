@react.component
let make = () => {
  <div>
    <p>
      {ReasonReact.string("This is a page completly written with ReasonML.")}
    </p>
    <ReasonCounter />
  </div>;
};

let default = make;
