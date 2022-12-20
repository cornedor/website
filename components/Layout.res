@react.component
let make = (~children, ~title) => {
  let (menuOpen, setMenuOpen) = React.useState(_ => false)
  // let router = Next.Router.useRouter()

  <div className="container">
    <SEO title /> // <-- move these to layout.tsx
    // <-- pass <DarkModeManager /> to here
    <header className="header">
      <div className="headerContent">
        <Next.Link href="/" className="headerName">
          {React.string(j`Corné Dorrestijn`)}
        </Next.Link>
        <button onClick={_ => setMenuOpen(s => !s)} className="hamburger" ariaLabel="Switch menu">
          <span />
          <span />
          <span />
        </button>
        <nav className={"navLinks" ++ (menuOpen ? " navLinks-open" : "")}>
          <DarkModeSwitcher />
          <Next.Link href="/posts" className="navLink"> {React.string("Blog")} </Next.Link>
          <Next.Link href="/" className="navLink"> {React.string("Snippets")} </Next.Link>
          <Next.Link href="/" className="navLink"> {React.string("About Me")} </Next.Link>
        </nav>
      </div>
    </header>
    <main className="main">
      <PageTopBend className="pageTop" />
      <div className="content">
        {switch title {
        | None => <> </>
        | Some(string) => <Title> {React.string(string)} </Title>
        }}
        children
      </div>
    </main>
    <Footer title />
  </div>
}

let default = make
