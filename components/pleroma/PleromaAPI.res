type pleromaAccountField = {
  name: string,
  value: string,
}

type pleromaAccount = {
  acct: string,
  avatar: string,
  avatar_static: string,
  bot: bool,
  created_at: string,
  display_name: string,
  // No idea
  emojis: array<unit>,
  fields: Js.nullable<array<pleromaAccountField>>,
  followers_count: int,
  following_count: int,
  header: string,
  header_static: string,
  id: string,
  is_locked: bool,
  mute_expires_at: Js.nullable<string>,
  note: Js.nullable<string>,
  statuses_count: int,
  url: string,
  username: string,
}

type pleromaApplication = {
  name: string,
  website: string,
}

type pleromaCard = {
  description: string,
  image: Js.nullable<string>,
  provider_name: Js.nullable<string>,
  provider_url: string,
  title: string,
  \"type": [#link | #photo | #video | #rich],
  url: string,
}

type pleromaMedia = {
  description: Js.nullable<string>,
  id: string,
  preview_url: string,
  remote_url: Js.nullable<string>,
  text_url: string,
  \"type": [#image | #video | #audio | #unknown],
  url: string,
}

type pleromaTag = {
  name: string,
  url: string,
}

type rec pleromaStatus = {
  account: pleromaAccount,
  application: Js.nullable<pleromaApplication>,
  bookmarked: bool,
  card: Js.nullable<unit>,
  content: string,
  created_at: string,
  edited_at: string,
  favourited: bool,
  favourites_count: int,
  id: string,
  in_reply_to_account_id: Js.nullable<string>,
  in_reply_to_id: Js.nullable<string>,
  language: Js.nullable<string>,
  media_attachments: array<pleromaMedia>,
  reblog: Js.nullable<pleromaStatus>,
  reblogged: bool,
  sensitive: bool,
  spoiler_text: Js.nullable<string>,
  tags: array<pleromaTag>,
  reblogs_count: int,
  replies_count: int,
  text: string,
  uri: string,
  url: Js.nullable<string>,
  visibility: [#public | #unlisted | #local | #"private" | #direct | #list],
}

type pleromaStatuses = Js.nullable<array<pleromaStatus>>

let fetchStatuses = (): Promise.t<Js.Json.t> => {
  open Fetch

  fetch(
    "https://cd0.nl/api/v1/accounts/AQrH5G919Oh37LnIy8/statuses",
    {
      method: #GET,
    },
  )->Promise.then(Response.json)
}
