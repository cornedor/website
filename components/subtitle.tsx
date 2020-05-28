import classnames from 'classnames'
import styles from './subtitle.module.css'
import { HTMLProps } from 'react'

const Subtitle = (props: HTMLProps<HTMLHeadingElement>) => (
  <h2 className={classnames(styles.subtitle, props.className)} {...props} />
)

export default Subtitle
