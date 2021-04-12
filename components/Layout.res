@react.component
let make = (~children, ~title, ()) => {
  let (menuOpen, setMenuOpen) = React.useState(_ => false)
  <div className="container">
    <SEO title /> // <-- move these to layout.tsx
    <Fonts />
    // <-- pass <DarkModeManager /> to here
    <header className="header">
      <div className="headerContent">
        <Next.Link href="/">
          <a className="headerName"> {React.string(j`Corné Dorrestijn`)} </a>
        </Next.Link>
        <button onClick={_ => setMenuOpen(s => !s)} className="hamburger" ariaLabel="Switch menu">
          <span /> <span /> <span />
        </button>
        <nav className={"navLinks" ++ (menuOpen ? " navLinks-open" : "")}>
          <DarkModeSwitcher />
          <Next.Link href="/posts"> <a className="navLink"> {React.string("Blog")} </a> </Next.Link>
          <Next.Link href="/"> <a className="navLink"> {React.string("Snippets")} </a> </Next.Link>
          <Next.Link href="/"> <a className="navLink"> {React.string("About Me")} </a> </Next.Link>
        </nav>
      </div>
    </header>
    <main className="main">
      <PageTopBend className="pageTop" />
      <div className="content"> <Title> {React.string(title)} </Title> children </div>
    </main>
  </div>
}

export default = make
