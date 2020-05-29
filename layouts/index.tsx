import Layout from '../components/layout'

export default function DefaultLayout(frontMatter: any) {
  return ({ children }: any) => (
    <Layout title={frontMatter.title}>{children}</Layout>
  )
}
