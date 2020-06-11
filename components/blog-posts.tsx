// @ts-ignore so weird this doesn't work ;-)
import { frontMatter as posts } from '../pages/posts/*.mdx'
import Link from 'next/link'
import BlogPost from './BlogPost.gen'

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
      <BlogPost
        title={post.title}
        excerpt={post.excerpt}
        path={post.__resourcePath}
      />
    ))}
  </>
)

export default BlogPosts
