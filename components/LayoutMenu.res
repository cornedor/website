@@directive("'use client';")

@react.component
let make = (~children) => {
  let (menuOpen, setMenuOpen) = React.useState(_ => false)

  <>
    <button onClick={_ => setMenuOpen(s => !s)} className="hamburger" ariaLabel="Switch menu">
      <span />
      <span />
      <span />
    </button>
    <nav className={"navLinks" ++ (menuOpen ? " navLinks-open" : "")}> children </nav>
  </>
}
