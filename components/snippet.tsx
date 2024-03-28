import Refractor from 'react-refractor'
import { useEffect, useState } from 'react'
import { dmMono } from './fonts'

export type SnippetProps = Refractor.Props

const languageCache: string[] = []

const Snippet = ({ language, ...props }: Refractor.Props) => {
  const [isLanguageLoaded, setIsLanguageLoaded] = useState<boolean>(false)
  useEffect(() => {
    if (!languageCache.includes(language)) {
      import(
        /* webpackMode: "lazy", webpackChunkName: "refractor-lang-[request]" */
        `refractor/lang/${language}`
      ).then((lang) => {
        Refractor.registerLanguage(lang.default)
        languageCache.push(language)
        setIsLanguageLoaded(true)
      })
    } else {
      setIsLanguageLoaded(true)
    }
  }, [language])

  return isLanguageLoaded ? (
    <Refractor
      {...props}
      language={language}
      inline
      className={`language-${language} ${dmMono.variable}`}
    />
  ) : (
    // <pre className="language-clike">
    <code className="language-clike">{props.value}</code>
    // </pre>
  )
}

export default Snippet
