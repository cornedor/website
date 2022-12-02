import { ReactNode } from 'react'
import Layout from '../components/Layout.bs'

export default function DefaultLayout({ children, frontMatter }: any) {
  return <Layout title={frontMatter.title}>{children}</Layout>
}
