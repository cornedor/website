import { ReactNode } from 'react'
import styles from './title.module.css'

interface TitleProps {
  children: ReactNode
}

const Title = ({ children }: TitleProps) => (
  <h1 className={styles.title}>{children}</h1>
)

export default Title
