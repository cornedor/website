// Due to issues with Next.JS and reason-react we need to do this in TypeScript
// for now.
//  - https://github.com/reasonml/reason-react/pull/603
//  - https://github.com/vercel/next.js/issues/12984
import Head from 'next/head'

interface FontsProps {
  fonts: string
}

const Fonts = ({ fonts }: FontsProps) => (
  <>
    <link rel="preload" as="style" href={fonts} />
    <link rel="preconnect" href="https://fonts.gstatic.com" crossOrigin="" />
    <link
      href={fonts}
      rel="stylesheet"
      media="print"
      // @ts-ignore
      onLoad="this.media = 'all'"
    />
  </>
)

export default Fonts
