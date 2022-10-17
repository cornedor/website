import Document, { Head, Html, Main, NextScript } from 'next/document'
import Script from 'next/script'

export default class MyDocument extends Document {
  render() {
    return (
      <Html lang="en">
        <Head>
          <link
            rel="preconnect"
            href="https://fonts.gstatic.com"
            crossOrigin=""
          />
          <link
            href="https://fonts.googleapis.com/css2?family=Balsamiq+Sans:ital,wght@0,400;0,700;1,400&family=Pacifico&display=swap"
            rel="stylesheet"
            media="all"
          />
          <meta name="flattr:id" content="pev69k" />
        </Head>
        <body>
          <Main />
          <NextScript />
          <Script
            id="hotjar"
            strategy="afterInteractive"
            dangerouslySetInnerHTML={{
              __html: `
              (function(h,o,t,j,a,r){
                h.hj=h.hj||function(){(h.hj.q=h.hj.q||[]).push(arguments)};
                h._hjSettings={hjid:3204957,hjsv:6};
                a=o.getElementsByTagName('head')[0];
                r=o.createElement('script');r.async=1;
                r.src=t+h._hjSettings.hjid+j+h._hjSettings.hjsv;
                a.appendChild(r);
              })(window,document,'https://static.hotjar.com/c/hotjar-','.js?sv=');
              `,
            }}
          />
          <Script
            id="Cookiebot"
            src="https://consent.cookiebot.com/uc.js"
            data-cbid="b772e023-b834-403e-a781-509ee5e914fb"
            type="text/javascript"
            async
            strategy="afterInteractive"
          ></Script>
          <Script
            id="CookieDeclaration"
            src="https://consent.cookiebot.com/b772e023-b834-403e-a781-509ee5e914fb/cd.js"
            type="text/javascript"
            async
            strategy="afterInteractive"
          ></Script>
        </body>
      </Html>
    )
  }
}
