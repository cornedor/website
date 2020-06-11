[@react.component]
let make = (~title) => {
  let fullTitle = "Corné Dorrestijn - " ++ title;

  <Next.Head>
    <link rel="icon" href="/favicon.ico" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <meta httpEquiv="X-UA-Compatible" content="ie=edge" />
    <meta
      name="description"
      content="Learn how to build a personal website using Next.js"
    />
    <meta
      property="og:image"
      content="https://og-image.now.sh/Blog.png?theme=light&md=0&fontSize=75px&images=https%3A%2F%2Fassets.zeit.co%2Fimage%2Fupload%2Ffront%2Fassets%2Fdesign%2Fnextjs-black-logo.svg"
    />
    <meta property="og:title" content=fullTitle />
    <title> {ReasonReact.string(fullTitle)} </title>
  </Next.Head>;
};

[@genType]
let default = make;