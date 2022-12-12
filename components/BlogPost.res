let getSlugFromResourcePath = (path: string) => {
  Js.String.replaceByRe(%re("/\\.(mdx|tsx?|jsx?|ml|re)/gi"), "", path)
}

type postMeta = {
  title: string,
  created_at: int,
  excerpt: string,
}

type post = {
  slug: string,
  meta: postMeta,
}

@react.component
let make = (~title="", ~excerpt="", ~path: string, ~created_at: float) => {
  let date = Js.Date.fromFloat(created_at)
  let dateTime = Js.Date.toTimeString(date)
  let formattedDate = Intl.DateTime.make(
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
  )

  <Next.Link href={getSlugFromResourcePath(path)} className="blogLink">
    <article>
      <h1> {React.string(title)} </h1>
      <p> {React.string(excerpt)} </p>
      <time dateTime className="blogLinkTime"> {React.string(formattedDate)} </time>
    </article>
  </Next.Link>
}

let default = make

let sortBlogPosts = (posts: array<post>) =>
  Js.Array2.sortInPlaceWith(posts, (itemA, itemB) => {
    itemA.meta.created_at < itemB.meta.created_at ? 1 : -1
  })
