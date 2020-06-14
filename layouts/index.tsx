import Layout from '../components/Layout.gen'

export default function DefaultLayout(frontMatter: any) {
  return ({ children }: any) => (
    <Layout title={frontMatter.title}>{children}</Layout>
  )
}
