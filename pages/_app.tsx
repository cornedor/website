import '../styles/global.css'
import '../styles/prism.css'
import { AppProps } from 'next/app'
import { ReactNode } from 'react'
import { MDXProvider } from '@mdx-js/react'
import { MDXComponents } from 'mdx/types'
import { Title } from '../components/Title.bs'
import { Subtitle } from '../components/Subtitle.bs'
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
      <Component {...pageProps} />
    </MDXProvider>
  )
}
