@react.component
let make = (~children, ~title) => {
  // let router = Next.Router.useRouter()

  <div className="container">
    <SEO title /> // <-- move these to layout.tsx
    <CommonIcons />
    // <-- pass <DarkModeManager /> to here
    <header className="header">
      <div className="headerContent">
        <Next.Link href="/" className="headerName">
          {React.string(j`Corné Dorrestijn`)}
        </Next.Link>
        <LayoutMenu>
          <DarkModeSwitcher />
          <Next.Link href="/fediverse" className="navLink"> {React.string("Fediverse")} </Next.Link>
          <Next.Link href="/posts" className="navLink"> {React.string("Blog")} </Next.Link>
          <Next.Link href="/snippets" className="navLink"> {React.string("Snippets")} </Next.Link>
          <Next.Link href="/" className="navLink"> {React.string("About Me")} </Next.Link>
        </LayoutMenu>
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
