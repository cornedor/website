import '../styles/global.css'
import '../styles/prism.css'
import { AppProps } from 'next/app'
import { ReactNode } from 'react'
import { MDXProvider } from '@mdx-js/react'
import { MDXComponents } from 'mdx/types'
import Title from '../components/Title.gen'
import Subtitle from '../components/Subtitle.gen'
import SnippetLoader from '../components/snippet-loader'
import DarkModeManager from '../components/dark-mode-manager'
import Head from 'next/head'

const mapping: MDXComponents = {
  h1: Title,
  h2: Subtitle,
  code: SnippetLoader,
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
