[@react.component]
let make = (~children, ~title, ()) =>
  <div className="container">
    <SEO title /> // <-- move these to layout.tsx
    <Fonts />
    // <-- pass <DarkModeManager /> to here
    <header className="header">
      <div className="headerContent">
        <Next.Link href="/">
          <a className="headerName">
            {ReasonReact.string({j|Corné Dorrestijn|j})}
          </a>
        </Next.Link>
        <nav className="navLinks">
          <DarkModeSwitcher />
          <Next.Link href="/posts">
            <a className="navLink"> {ReasonReact.string("Blog")} </a>
          </Next.Link>
          <Next.Link href="/">
            <a className="navLink"> {ReasonReact.string("Snippets")} </a>
          </Next.Link>
          <Next.Link href="/">
            <a className="navLink"> {ReasonReact.string("About Me")} </a>
          </Next.Link>
        </nav>
      </div>
    </header>
    <main className="main">
      <PageTopBend className="pageTop" />
      <div className="content">
        <Title> {ReasonReact.string(title)} </Title>
        children
      </div>
    </main>
  </div>; // <-- links etc.

[@genType]
let default = make;