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
};

[@react.component]
let make = (~children=?, ~title, ()) =>
  <div className=Styles.container>
    <SEO title /> // <-- move these to layout.tsx
    <Fonts />
    // <-- pass <DarkModeSwitcher /> to here
    <header className=Styles.header>
      <div className=Styles.headerContent>

          <Next.Link href="/">
            <a className=Styles.name>
              {ReasonReact.string("Corné Dorrestijn")}
            </a>
          </Next.Link>
          <div className=Styles.links />
        </div> // <-- links etc.
    </header>
  </div>;

[@genType]
let default = make;