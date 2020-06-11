import '../styles/global.css'
import '../styles/prism.css'
import { AppProps } from 'next/app'
import { ReactNode } from 'react'
import { MDXProvider } from '@mdx-js/react'
import Title from '../components/Title.gen'
import Subtitle from '../components/Subtitle.gen'
import SnippetLoader from '../components/snippet-loader'

const mapping = {
  h1: Title,
  h2: Subtitle,
  code: SnippetLoader,
  // TODO: needs more compact styling for inline
  // inlineCode: SnippetLoader,
}

export default function App({ Component, pageProps }: AppProps) {
  return (
    <MDXProvider components={mapping}>
      <Component {...pageProps} />
    </MDXProvider>
  )
}
