@react.component
let make = (~children: React.element, ~summaryContent: React.element) =>
  <details>
    <summary> summaryContent </summary>
    children
  </details>

let default = make
