import Head from 'next/head'
import styles from './layout.module.css'
import Link from 'next/link'
import PageTopBend from './page-top-bend'
import SunIcon from './icons/sun'
import MoonIcon from './icons/moon'
import { useCallback } from 'react'
import LightSwitcher from './light-switcher'

export const siteTitle = 'Corné Dorrestijn'

export default function Layout({
  children,
  home,
}: {
  children: React.ReactNode
  home?: boolean
}) {
  const handleLightSwitchClick = useCallback(() => {
    const currentMode = window.localStorage.getItem('color-mode')
    localStorage.setItem(
      'color-mode',
      currentMode === 'dark' ? 'light' : 'dark',
    )
    // @ts-ignore
    window.updateDarkModeProperties?.()
  }, [])

  return (
    <div className={styles.container}>
      <Head>
        <link rel="icon" href="/favicon.ico" />
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
        <meta name="og:title" content={siteTitle} />
        <meta name="twitter:card" content="summary_large_image" />
        <link
          href="https://fonts.googleapis.com/css2?family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400&family=Pacifico&display=swap"
          rel="stylesheet"
        />
        <LightSwitcher />
      </Head>
      <header className={styles.header}>
        <div className={styles.headerContent}>
          <Link href="/">
            <a className={styles.name}>Corné Dorrestijn</a>
          </Link>
          <div className={styles.links}>
            <button
              className={styles.lightSwitch}
              onClick={handleLightSwitchClick}
              aria-label="Switch light mode"
            >
              <div className={styles.lightSwitchIcons}>
                <MoonIcon />
                <SunIcon />
              </div>
            </button>
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
        <div className={styles.content}>{children}</div>
      </main>
    </div>
  )
}
