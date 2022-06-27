import loadable from '@loadable/component'
import { SnippetProps } from './snippet'
import Head from 'next/head'
import { ReactNode } from 'react'

// These are somewhat bigger libraries, loading async for initial performance.
const Snippet = loadable(() => import('./snippet'))

interface SnippetLoaderProps {
  children?: ReactNode
  className: string
}

const SnippetLoader = ({ children, ...props }: SnippetLoaderProps) => {
  const snippetProps: SnippetProps = {
    value: String(children),
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
      {snippetProps.language ? (
        <Snippet {...snippetProps} fallback={fallback} />
      ) : (
        fallback
      )}
    </>
  )
}

export default SnippetLoader
