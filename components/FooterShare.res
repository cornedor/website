@@directive("'use client';")

type shareData = {
  url: option<string>,
  title: option<string>,
}

type shareFn = shareData => unit
@val @scope("navigator") external share: option<shareFn> = "share"

@react.component
let make = (~title) => {
  // let router = Next.Router.useRouter()
  let path = Next.Navigation.usePathname()

  let handleClick = _ => {
    switch share {
    | Some(_) =>
      let share = %raw("data => navigator.share(data).catch(() => {})")
      share({
        // url: Some(router.asPath),
        // TODO: fix this
        url: Some(path),
        title,
      })
    | _ => Js.log("No shareing")
    }
  }

  <a href="#" onClick={handleClick}> {React.string("Share")} </a>
}
