let getSlugFromResourcePath = (path: string) => {
  Js.String.replaceByRe(%re("/\\.(mdx|tsx?|jsx?|ml|re)/gi"), "", path)
}

@react.module
let make = (~title="", ~excerpt="", ~path: string, ~created_at: float) => {
  let date = Js.Date.fromFloat(created_at)
  let dateTime = Js.Date.toTimeString(date)
  let formattedDate =
  Intl.DateTime.make(
    ~date,
    ~locale=Some("en"),
    ~options=Intl.DateTime.Options.make(
        ~year=Some(#numeric),
        ~weekday=Some(#long),
        ~day=Some(#"2-digit"),
        ~month=Some(#long),
        (),
      ),
    (),
  );

  <Next.Link href={getSlugFromResourcePath(path)}>
    <a className="blogLink">
      <article>
        <h1> {React.string(title)} </h1>
        <p> {React.string(excerpt)} </p>
        <time dateTime className="blogLinkTime"> {React.string(formattedDate)} </time>
      </article>
    </a>
  </Next.Link>
}

export default = make
