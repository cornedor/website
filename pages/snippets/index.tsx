import { GetStaticProps } from 'next'
import Layout from '../../components/Layout.bs'
import BlogPost, { sortBlogPosts } from '../../components/BlogPost.bs'
import fs from 'fs/promises'
import matter from 'gray-matter'
import path from 'path'

const basePath = path.resolve('pages/snippets')

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
    <Layout title="Snippets">
      {mdxContents.map(({ meta, slug }) => (
        <BlogPost
          key={slug}
          title={meta.title}
          created_at={meta.created_at ?? 0}
          excerpt={meta.excerpt}
          path={'snippets/' + slug ?? ''}
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
  const mdxFiles = files.filter((file) => file.name.endsWith('mdx'))

  const mdxContentsUnsorted = await Promise.all(
    mdxFiles.map((file) => parseFile(file.name)),
  )

  const mdxContents = sortBlogPosts(mdxContentsUnsorted)

  return {
    props: {
      mdxContents,
    },
  }
}
