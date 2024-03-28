import { Balsamiq_Sans, Pacifico, DM_Mono } from 'next/font/google'

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

export const dmMono = DM_Mono({
  weight: ['400', '500'],
  variable: '--font-mono',
  subsets: ['latin'],
})
