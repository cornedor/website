const DarkModeManager = () => (
  <script
    dangerouslySetInnerHTML={{
      __html: `
    function getLightOrDarkMode() {
      const userPreference = window.localStorage.getItem('color-mode')
      if (userPreference && ['dark', 'light'.includes(userPreference)]) {
        return userPreference
      }
    
      const mql = window.matchMedia('(prefers-color-scheme: dark)')
      if (typeof mql.matches == 'boolean') {
        return mql.matches ? 'dark' : 'light'
      }
    
      return 'light'
    }
    
    function updateDarkModeProperties() {
      const colorMode = getLightOrDarkMode()
      const root = document.documentElement
    
      const properties =
        colorMode === 'dark'
          ? {
              '--color-primary': '#a376d0',
              '--color-secondary': '#383140',
              '--color-text': '#dbd0e5',
              '--color-background': '#000000',
    
              '--light-switch-icon-start-pos': '0',
              '--light-switch-icon-end-pos': '-34px',
            }
          : {
              '--color-primary': '#8c49cf',
              '--color-secondary': '#f1e9f9',
              '--color-text': '#000000',
              '--color-background': '#ffffff',
    
              '--light-switch-icon-start-pos': '-34px',
              '--light-switch-icon-end-pos': '-0',
            }
    
      for (const [property, value] of Object.entries(properties)) {
        root.style.setProperty(property, value)
      }
    }
    updateDarkModeProperties();

    window.addEventListener('storage', updateDarkModeProperties)
  `,
    }}
  />
)

export default DarkModeManager
