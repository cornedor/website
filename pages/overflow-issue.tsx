export default function OverflowIssue() {
  return (
    <div>
      <img
        style={{
          border: 'solid 2px black',
          width: '200px',
          height: '400px',
          objectFit: 'cover',
          overflow: 'visible',
        }}
        src="https://www.chromium.org/_assets/customLogo.png"
        alt=""
      />
      <br />
      <input
        type="image"
        style={{
          border: 'solid 2px black',
          width: '200px',
          height: '400px',
          objectFit: 'cover',
          overflow: 'visible',
        }}
        src="https://www.chromium.org/_assets/customLogo.png"
        alt=""
      />
    </div>
  )
}
