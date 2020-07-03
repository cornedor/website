const withMdxEnhanced = require('next-mdx-enhanced')
const withTM = require('next-transpile-modules')(['bs-platform'])
const withSourceMaps = require('@zeit/next-source-maps')

module.exports = withSourceMaps(withMdxEnhanced({
  layoutPath: 'layouts',
  defaultLayout: true,
  fileExtensions: ['mdx'],
  remarkPlugins: [],
  rehypePlugins: [],
  extendFrontMatter: {
    process: (mdxContent, frontMatter) => {},
    phase: 'prebuild|loader|both',
  },
})(
  withTM({
    pageExtensions: ['jsx', 'js', 'bs.js', 'ts', 'tsx'],
  }),
))
