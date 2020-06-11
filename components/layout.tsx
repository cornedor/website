import Head from 'next/head'
import styles from './layout.module.css'
import Link from 'next/link'
import PageTopBend from '../components/PageTopBend.gen'
import LightSwitcher from '../components/dark-mode-manager'
import Title from '../components/Title.gen'
import DarkModeSwitcher from '../components/dark-mode-switcher'
import { ReactNode, useLayoutEffect, useState } from 'react'

export const siteTitle = 'Corné Dorrestijn'

interface LayoutProps {
  children: ReactNode
  title: string
}

const fonts =
  'https://fonts.googleapis.com/css2?family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400&family=Pacifico&display=swap'

export default function Layout({ children, title }: LayoutProps) {
  const [showFont, setShowFont] = useState(false)
  const fullTitle = `${siteTitle} - ${title}`
  return (
    <div className={styles.container}>
      <Head>
        <link rel="icon" href="/favicon.ico" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta http-equiv="X-UA-Compatible" content="ie=edge" />
        <meta
          name="description"
          content="Learn how to build a personal website using Next.js"
        />
        <meta
          property="og:image"
          content={`https://og-image.now.sh/${encodeURI(
            siteTitle,
          )}.png?theme=light&md=0&fontSize=75px&images=https%3A%2F%2Fassets.zeit.co%2Fimage%2Fupload%2Ffront%2Fassets%2Fdesign%2Fnextjs-black-logo.svg`}
        />
        <meta name="og:title" content={fullTitle} />
        <title>{fullTitle}</title>
        <meta name="twitter:card" content="summary_large_image" />
        <link
          rel="preconnect"
          href="https://fonts.gstatic.com"
          crossOrigin=""
        />
        <link rel="preload" as="style" href={fonts} />
        <LightSwitcher />
        <link
          href={fonts}
          rel="stylesheet"
          media={showFont ? 'print' : 'all'}
          onLoad={() => setShowFont(true)}
        />
      </Head>
      <header className={styles.header}>
        <div className={styles.headerContent}>
          <Link href="/">
            <a className={styles.name}>Corné Dorrestijn</a>
          </Link>
          <div className={styles.links}>
            <DarkModeSwitcher />
            <Link href="/">
              <a className={styles.link}>Blog</a>
            </Link>
            <Link href="/">
              <a className={styles.link}>Snippets</a>
            </Link>
            <Link href="/">
              <a className={styles.link}>About Me</a>
            </Link>
          </div>
        </div>
      </header>
      <main className={styles.main}>
        <PageTopBend className={styles.pageTop} />
        <div className={styles.content}>
          <Title>{title}</Title>
          {children}
        </div>
      </main>
    </div>
  )
}
