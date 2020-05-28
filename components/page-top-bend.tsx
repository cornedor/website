/**
 * This component is the bend at the top of the page.
 *
 * _______________________
 * Header             Menu
 * ___----''''''''----___ <<-- this one
 *   Content, lorem ips.
 *
 * TODO: Does this explanation help?
 */

function PageTopBend(props: React.SVGProps<SVGSVGElement>) {
  return (
    <svg
      width={1152}
      height={52}
      viewBox="0 0 1152 52"
      fill="none"
      preserveAspectRatio="none"
      {...props}
    >
      <path
        d="M576 0C350.143 0 0 52 0 52h1152S801.857 0 576 0z"
        fill="currentColor"
      />
    </svg>
  )
}

export default PageTopBend
