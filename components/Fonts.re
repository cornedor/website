let fonts = "https://fonts.googleapis.com/css2?family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400&family=Pacifico&display=swap";

// @TODO: re-add <link rel="preload" _as="style" href=fonts />
// https://github.com/reasonml/reason-react/pull/603

[@react.component]
let make = () => {
  let (showFont, setShowFont) = React.useState(() => false);
  <Next.Head>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="" />
    <link
      href=fonts
      rel="stylesheet"
      media={showFont ? "print" : "all"}
      onLoad={_ => setShowFont(_ => true)}
    />
  </Next.Head>;
};