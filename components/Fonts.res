let fonts = "https://fonts.googleapis.com/css2?family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400&family=Pacifico&display=swap"

// @TODO: re-add <link rel="preload" _as="style" href=fonts />
// https://github.com/reasonml/reason-react/pull/603

// @TODO: re-add async loading of the css file
// https://github.com/vercel/next.js/issues/12984

@react.component
let make = () => {
  <Next.Head>
    <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="" />
    <link href=fonts rel="stylesheet" media="all" />
  </Next.Head>
}
