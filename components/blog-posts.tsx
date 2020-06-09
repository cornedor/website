// @ts-ignore so weird this doesn't work ;-)
import { frontMatter as posts } from '../pages/posts/*.mdx'
import Link from 'next/link'

interface BlogPost {
  title?: string
  excerpt?: string
  __resourcePath: string
}

function getSlugFromResourcePath({ __resourcePath }: BlogPost) {
  return __resourcePath.replace(/\.(mdx|tsx?|jsx?|ml|re)/gi, '')
}

const BlogPosts = () => (
  <>
    {posts.map((post: BlogPost) => (
      <Link href={getSlugFromResourcePath(post)}>
        <a>
          <article>
            <h1>{post.title}</h1>
            <p>{post.excerpt}</p>
          </article>
        </a>
      </Link>
    ))}
  </>
)

export default BlogPosts
