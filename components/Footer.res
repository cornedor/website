@react.component
let make = (~title) => {
  <footer className="siteFooter">
    {React.string("Follow me: ")}
    <a rel="me" href="https://cd0.nl/@corne"> {React.string("@corne@cd0.nl")} </a>
    {React.string(" - ")}
    <a href="https://github.com/cornedor"> {React.string("cornedor on GitHub")} </a>
    {React.string(" - ")}
    <FooterShare title />
  </footer>
}
