type shareData = {
  url: option<string>,
  title: option<string>,
}

type shareFn = shareData => unit
@val @scope("navigator") external share: option<shareFn> = "share"

@react.component
let make = (~title) => {
  let router = Next.Router.useRouter()

  let handleClick = _ => {
    switch share {
    | Some(_) =>
      let share = %raw("data => navigator.share(data).catch(() => {})")
      share({
        url: Some(router.asPath),
        title,
      })
    | _ => Js.log("No shareing")
    }
  }

  <footer className="siteFooter">
    {React.string("Follow me: ")}
    <a rel="me" href="https://mastodon.nl/@cornedor"> {React.string("@cornedor@mastodon.nl")} </a>
    {React.string(" - ")}
    <a href="https://github.com/cornedor"> {React.string("cornedor on GitHub")} </a>
    {React.string(" - ")}
    <a href="#" onClick={handleClick}> {React.string("Share")} </a>
  </footer>
}
