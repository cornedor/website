// const bsconfig = import('./bsconfig.json')
// const withMdxEnhanced = import('next-mdx-enhanced')
// const transpileModules = ['bs-platform']
// const transpileModules = ["rescript"].concat(bsconfig["bs-dependencies"]);
// const withTM = import('next-transpile-modules')(transpileModules)
// const withSourceMaps = import('@zeit/next-source-maps')
// const remarkFrontmatter = import('remark-frontmatter/index')

import bsconfig from './bsconfig.json' assert {type: "json"}
import nextTranspileModules from 'next-transpile-modules'
import withSourceMaps from '@zeit/next-source-maps'
import remarkFrontmatter from 'remark-frontmatter'
import nextMdx from '@next/mdx'


const transpileModules = ["rescript", 'refractor'].concat(bsconfig["bs-dependencies"]);
// const withTM = nextTranspileModules(transpileModules)

const withMDX = nextMdx({
  extension: /\.mdx?$/,
  options: {
    remarkPlugins: [remarkFrontmatter],
    rehypePlugins: [],
    // providerImportSource: "@mdx-js/react",
  },
})


export default withSourceMaps(withMDX({
  transpilePackages: transpileModules,
  pageExtensions: ['jsx', 'js', 'bs.js', 'ts', 'tsx', 'md', 'mdx'],
}));
