import Head from 'next/head'
import Layout, { siteTitle } from '../components/layout'
import Title from '../components/title'
import Subtitle from '../components/subtitle'

export default function Home() {
  return (
    <Layout>
      <Head>
        <title>{siteTitle}</title>
      </Head>
      <Title>My little tricks and snips.</Title>
      <p>Dear reader,</p>
      <p>
        Ive often had to hunt for little tricks I would use for certain tasks,
        and sometimes those little tricks would include multiple steps. Other
        times I invented my own little tricks. But often I would also lose those
        little tricks. Thats why I’ve decided to start a blog. A place where I
        can store those little tricks, and also share them with the world. But I
        hope this will also be a place where I can share more that just a few
        little tricks.
      </p>
      <Subtitle>Whats next?</Subtitle>
      <p>
        Ive often had to hunt for little tricks I would use for certain tasks,
        and sometimes those little tricks would include multiple steps. Other
        times I invented my own little tricks. But often I would also lose those
        little tricks. Thats why I’ve decided to start a blog. A place where I
        can store those little tricks, and also share them with the world. But I
        hope this will also be a place where I can share more that just a few
        little tricks.
      </p>
    </Layout>
  )
}
