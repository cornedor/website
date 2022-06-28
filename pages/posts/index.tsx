import { GetStaticProps } from 'next'
import Layout from '../../components/Layout.gen'
import BlogPost from '../../components/BlogPost.gen'
import fs from 'fs/promises'
import matter from 'gray-matter'
import path from 'path'

const basePath = path.resolve('pages/posts')

interface Props {
  mdxContents: Array<{
    slug: string
    meta: {
      title?: string
      created_at?: number
      excerpt?: string
    }
  }>
}

export default function Posts({ mdxContents }: Props) {
  return (
    <Layout title="Posts">
      {mdxContents.map(({ meta, slug }) => (
        <BlogPost
          key={slug}
          title={meta.title}
          created_at={meta.created_at ?? 0}
          excerpt={meta.excerpt}
          path={'posts/' + slug ?? ''}
        />
      ))}
    </Layout>
  )
}

async function parseFile(filename: string) {
  const content = await fs.readFile(`${basePath}/${filename}`, 'utf-8')
  const parsed = matter(content)
  return {
    slug: filename.replace(/\.mdx?$/, ''),
    meta: parsed.data,
  }
}

export const getStaticProps: GetStaticProps = async (context) => {
  const files = await fs.readdir(basePath, { withFileTypes: true })
  console.log(files)
  const mdxFiles = files.filter((file) => file.name.endsWith('mdx'))

  const mdxContents = await Promise.all(
    mdxFiles.map((file) => parseFile(file.name)),
  )

  return {
    props: {
      mdxContents,
    },
  }
}
