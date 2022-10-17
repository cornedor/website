import Script from 'next/script'
import LayoutBs from '../components/Layout.bs'
import DefaultLayout from '../layouts'

export default function Cookies() {
  return (
    <LayoutBs title="Cookies">
      <main className="content">
        <div id="CookieDeclaration"></div>
        <Script
          src="https://consent.cookiebot.com/b772e023-b834-403e-a781-509ee5e914fb/cd.js"
          type="text/javascript"
          strategy="afterInteractive"
        ></Script>
      </main>
    </LayoutBs>
  )
}
