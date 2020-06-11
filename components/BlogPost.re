module Styles = {
  open Css;

  let link = style([unsafe("color", "inherit")]);
};

let getSlugFromResourcePath = (path: string) => {
  Js.String.replaceByRe([%re "/\.(mdx|tsx?|jsx?|ml|re)/gi"], "", path);
};

[@react.module]
let make = (~title="", ~excerpt="", ~path: string) => {
  <Next.Link href={getSlugFromResourcePath(path)}>
    <a className=Styles.link>
      <article>
        <h1> {ReasonReact.string(title)} </h1>
        <p> {ReasonReact.string(excerpt)} </p>
      </article>
    </a>
  </Next.Link>;
};

[@genType]
let default = make;