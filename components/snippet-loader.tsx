import dynamic from 'next/dynamic'
import { SnippetProps } from './snippet'
import Head from 'next/head'

// These are somewhat bigger libraries, loading async for initial performance.
const Snippet = dynamic(() => import('./snippet'))

interface SnippetLoaderProps {
  children: string
  className: string
}

const SnippetLoader = ({ children, ...props }: SnippetLoaderProps) => {
  const snippetProps: SnippetProps = {
    value: children,
    // The language is available as a class name when defined in the mdx file
    language: props.className?.split('-')[1],
  }

  const fallback = (
    <pre className="language-clike">
      <code className="language-clike">{children}</code>
    </pre>
  )

  return (
    <>
      <Head>
        <link
          href="https://fonts.googleapis.com/css2?family=DM+Mono:wght@500&amp;display=swap"
          rel="stylesheet"
        />
      </Head>
      {snippetProps.language ? <Snippet {...snippetProps} /> : fallback}
    </>
  )
}

export default SnippetLoader
