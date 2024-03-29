let getAccount = (status: PleromaAPI.pleromaStatus) =>
  switch Js.Nullable.toOption(status.reblog) {
  | Some(reblog) => reblog.account
  | None => status.account
  }

let getIcon = (status: PleromaAPI.pleromaStatus): Icon.iconIds =>
  switch status.visibility {
  | #public => #globe
  | #list => #globe
  | #local => #globe
  | #unlisted => #unlock
  | #"private" => #lock
  | #direct => #envelope
  }

let getMediaLink = (status: PleromaAPI.pleromaMedia) =>
  switch (Js.Nullable.toOption(status.text_url), Js.Nullable.toOption(status.remote_url)) {
  | (Some(url), _) => url
  | (None, Some(url)) => url
  | _ => "#"
  }

@react.component
let make = (~data: PleromaAPI.pleromaStatuses) => {
  <Layout title={Some("Fediverse")}>
    {switch Js.Nullable.toOption(data) {
    | Some(statuses) => {
        let statusElems = Belt.Array.map(statuses, status => {
          let account = getAccount(status)
          let (reblog, content, media) = switch Js.Nullable.toOption(status.reblog) {
          | Some(reblog) => (
              <span className="fedi_statusReblogged fedi_textWithIcon">
                {React.string("reblogged")}
                <Icon id=#repeat />
              </span>,
              reblog.content,
              reblog.media_attachments,
            )
          | None => (<> </>, status.content, status.media_attachments)
          }

          let (dateTime, formattedDate) = BlogPost.formatDate(Js.Date.fromString(status.created_at))
          let media = Belt.Array.map(media, item =>
            switch item.\"type" {
            | #image =>
              <Next.Link href={getMediaLink(item)} key={item.id}>
                <img
                  className="fedi_statusMediaImg"
                  src={item.preview_url}
                  width="200"
                  height="200"
                  loading=#"lazy"
                  alt={switch Js.Nullable.toOption(item.description) {
                  | Some(str) => str
                  | _ => ""
                  }}
                />
              </Next.Link>
            | #video =>
              <video
                className="fedi_statusMediaVideo"
                src={getMediaLink(item)}
                controls=true
                key={item.id}
                alt={switch Js.Nullable.toOption(item.description) {
                | Some(str) => str
                | _ => ""
                }}
              />
            | #unknown => <> </>
            | #audio => <> </>
            }
          )

          let content =
            <>
              <div className="fedi_content" dangerouslySetInnerHTML={{"__html": content}} />
              <div className="fedi_statusMedia"> {React.array(media)} </div>
            </>

          <div className="fedi_status" key={status.id}>
            <div className="fedi_statusAvatar">
              <img
                src={account.avatar}
                width="100"
                height="100"
                className="fedi_statusAvatarImg"
                loading=#"lazy"
              />
            </div>
            <div className="fedi_statusContent">
              <div className="fedi_statusInfo">
                <Next.Link href={account.url}>
                  <strong> {React.string(account.display_name)} </strong>
                  <small> {React.string(" @" ++ account.acct)} </small>
                </Next.Link>
                reblog
                <div className="fedi_meta subtleText">
                  {switch Js.Nullable.toOption(status.url) {
                  | Some(url) =>
                    <Next.Link href={url}>
                      <time dateTime className="blogLinkTime"> {React.string(formattedDate)} </time>
                    </Next.Link>
                  | _ =>
                    <time dateTime className="blogLinkTime"> {React.string(formattedDate)} </time>
                  }}
                  <span
                    ariaLabel={"Visibility: " ++ (status.visibility :> string)}
                    title={"Visibility: " ++ (status.visibility :> string)}
                    className="fedi_textWithIcon">
                    <Icon id={getIcon(status)} />
                  </span>
                  <span ariaLabel="Replies" title="Replies" className="fedi_textWithIcon">
                    <Icon id=#cornerUpLeft />
                    {React.string(Belt.Int.toString(status.replies_count))}
                  </span>
                  <span ariaLabel="Reblogs" title="Reblogs" className="fedi_textWithIcon">
                    <Icon id=#repeat />
                    {React.string(Belt.Int.toString(status.reblogs_count))}
                  </span>
                </div>
              </div>
              {switch Js.Nullable.toOption(status.spoiler_text) {
              | Some(str) if Js.String2.length(str) > 1 =>
                <Spoiler
                  summaryContent={<>
                    <strong> {React.string("Spoiler: ")} </strong>
                    {React.string(str)}
                  </>}>
                  content
                </Spoiler>
              | _ => content
              }}
            </div>
          </div>
        })

        <div>
          <Next.Head>
            <meta name="robots" value="noindex, nofollow" />
          </Next.Head>
          <p> {React.string("Well hello there,")} </p>
          <p>
            {React.string(
              "You found my Fediverse page. This is nother special really, it is just a overview of my more recent posts on my Pleroma instance. You can also follow me on your Mastodon or other Fediverse connected service at @corne@cd0.nl",
            )}
          </p>
          <p> {React.string("Thanks, and see you later.")} </p>
          <div className="fedi"> {React.array(statusElems)} </div>
        </div>
      }

    | None => <p> {React.string("Could not fetch my latest statuses in the Fediverse")} </p>
    }}
  </Layout>
}

let default = make

let getStaticProps = _ctx =>
  // For Mastodon user IDs are required, Pleroma can handle user IDs or user handles.
  // PleromaAPI.fetchStatuses("mastodon.social", "1")->Promise.then(result => {
  PleromaAPI.fetchStatuses("cd0.nl", "corne")->Promise.then(result => {
    Promise.resolve({
      "props": {
        "data": result,
      },
      "revalidate": 60,
    })
  })
