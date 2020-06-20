module Styles = {
  open Css;

  let container = style([unsafe("background", "var(--color-background)")]);

  let header =
    style([
      padding3(~top=px(20), ~h=px(40), ~bottom=zero),
      height(px(180)),
      unsafe("background", "var(--gradient)"),
    ]);

  let headerContent =
    style([
      display(flexBox),
      justifyContent(spaceBetween),
      alignItems(center),
      maxWidth(px(1152)),
      margin2(~v=zero, ~h=auto),
    ]);

  let name =
    style([unsafe("fontFamily", "var(--font-title)"), fontSize(px(32))]);

  let links = style([display(flexBox), alignItems(center)]);

  let link =
    style([
      padding(px(10)),
      marginLeft(px(16)),
      lastOfType([paddingRight(zero)]),
    ]);

  let main =
    style([
      position(relative),
      unsafe("background", "var(--color-background)"),
    ]);

  let content =
    style([
      maxWidth(px(792)),
      padding2(~v=px(40), ~h=px(10)),
      margin2(~v=zero, ~h=auto),
      media("(min-width: 500px)", [padding(px(40))]),
    ]);

  let pageTop =
    style([
      position(absolute),
      width(pct(100.)),
      maxHeight(px(52)),
      height(vw(8.)),
      bottom(pct(100.)),
      objectFit(fill),
      unsafe("color", "var(--color-background, white)"),
    ]);
};

[@react.component]
let make = (~children, ~title, ()) =>
  <div className=Styles.container>
    <SEO title /> // <-- move these to layout.tsx
    <Fonts />
    // <-- pass <DarkModeManager /> to here
    <header className=Styles.header>
      <div className=Styles.headerContent>
        <Next.Link href="/">
          <a className=Styles.name>
            {ReasonReact.string({j|Corné Dorrestijn|j})}
          </a>
        </Next.Link>
        <div className=Styles.links>
          <DarkModeSwitcher />
          <Next.Link href="/">
            <a className=Styles.link> {ReasonReact.string("Blog")} </a>
          </Next.Link>
          <Next.Link href="/">
            <a className=Styles.link> {ReasonReact.string("Snippets")} </a>
          </Next.Link>
          <Next.Link href="/">
            <a className=Styles.link> {ReasonReact.string("About Me")} </a>
          </Next.Link>
        </div>
      </div>
    </header>
    <main className=Styles.main>
      <PageTopBend className=Styles.pageTop />
      <div className=Styles.content>
        <Title> {ReasonReact.string(title)} </Title>
        children
      </div>
    </main>
  </div>; // <-- links etc.

[@genType]
let default = make;