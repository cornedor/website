import Document, { Head, Html, Main, NextScript } from 'next/document'
import Script from 'next/script'
import { body, title } from '../components/fonts'
import { CSSProperties } from 'react'
import DarkModeManager from '../components/dark-mode-manager'

export default class MyDocument extends Document {
  render() {
    return (
      <Html lang="en">
        <Head>
          <link
            rel="preconnect"
            href="https://fonts.gstatic.com"
            crossOrigin=""
          />
          <link
            href="https://fonts.googleapis.com/css2?family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400&family=Pacifico&display=swap"
            rel="stylesheet"
            media="all"
          />
          <meta name="flattr:id" content="pev69k" />
        </Head>
        <body>
          <Main />
          <NextScript />
        </body>
      </Html>
    )
  }
}
