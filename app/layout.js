import './global.css'

import Layout from '../components/Layout.bs'
import { body, title } from '../components/fonts'
import DarkModeManager from '../components/dark-mode-manager'

export default function MainLayout({
  children,
}) {
  return (
    <html lang="en" style={
      {
        '--font-title': title.style.fontFamily,
        '--font-body': body.style.fontFamily,
      }
    }>
      <head>
        <meta name="flattr:id" content="pev69k" />
        <DarkModeManager />
      </head>
      <body>
        <Layout title="My little tricks and snips.">
          {children}
        </Layout>
      </body>
    </html>
  )
}
