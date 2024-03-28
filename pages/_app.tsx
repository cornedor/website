import { balsamiq, pacifico } from '../components/fonts'
import '../styles/global.css'
import '../styles/prism.css'
import { AppProps } from 'next/app'
import { ReactNode } from 'react'
import { MDXProvider } from '@mdx-js/react'
import { MDXComponents } from 'mdx/types'
import Title from '../components/Title.bs'
import Subtitle from '../components/Subtitle.bs'
import SnippetLoader from '../components/snippet-loader'
import DarkModeManager from '../components/dark-mode-manager'
import Head from 'next/head'
import Script from 'next/script'

const mapping: MDXComponents = {
  h1: Title,
  h2: Subtitle,
  code: SnippetLoader,
  pre: ({ children }) => (
    <pre className="refractor language-clike">{children}</pre>
  ),
  // TODO: needs more compact styling for inline
  // inlineCode: SnippetLoader,
}

export default function App({ Component, pageProps }: AppProps) {
  return (
    <MDXProvider components={mapping}>
      <Head>
        <DarkModeManager />
      </Head>
      <Script
        strategy="beforeInteractive"
        dangerouslySetInnerHTML={{
          __html: `window.plausible = window.plausible || function() { (window.plausible.q = window.plausible.q || []).push(arguments) }`,
        }}
      />
      <Script
        id="plausible"
        data-domain="corne.info"
        src="https://p.cd0.nl/js/script.js"
      />
      <main className={`${balsamiq.variable} ${pacifico.variable}`}>
        <Component {...pageProps} />
      </main>
    </MDXProvider>
  )
}
