import { useCallback } from 'react'
import styles from './dark-mode-switcher.module.css'
import MoonIcon from './icons/moon'
import SunIcon from './icons/sun'

const DarkModeSwitcher = (props: any) => {
  const handleLightSwitchClick = useCallback(() => {
    const currentMode = global.getLightOrDarkMode()
    localStorage.setItem(
      'color-mode',
      currentMode === 'dark' ? 'light' : 'dark',
    )
    // @ts-ignore
    window.updateDarkModeProperties?.()
  }, [])

  return (
    <button
      onClick={handleLightSwitchClick}
      aria-label="Switch light mode"
      className={styles.lightSwitch}
    >
      <div className={styles.lightSwitchIcons}>
        <MoonIcon />
        <SunIcon />
      </div>
    </button>
  )
}

export default DarkModeSwitcher
