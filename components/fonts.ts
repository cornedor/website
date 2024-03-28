import { Balsamiq_Sans, Pacifico } from 'next/font/google'

export const balsamiq = Balsamiq_Sans({
  style: ['italic', 'normal'],
  weight: ['400', '700'],
  variable: '--font-body',
  subsets: ['latin'],
})

export const pacifico = Pacifico({
  weight: '400',
  variable: '--font-title',
  subsets: ['latin'],
})
