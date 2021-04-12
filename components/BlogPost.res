let getSlugFromResourcePath = (path: string) => {
  Js.String.replaceByRe(%re("/\\.(mdx|tsx?|jsx?|ml|re)/gi"), "", path)
}

@react.module
let make = (~title="", ~excerpt="", ~path: string) => {
  <Next.Link href={getSlugFromResourcePath(path)}>
    <a className="blogLink">
      <article> <h1> {React.string(title)} </h1> <p> {React.string(excerpt)} </p> </article>
    </a>
  </Next.Link>
}

export default = make
