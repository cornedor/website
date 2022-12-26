type lineTypes =
  | Cd({path: string, fullpath: string})
  | Ls
  | File({path: string, fullpath: string, size: int})
  | Directory({path: string})

// Parse string to workable data
let rec parseTerminalOutput = (lines: array<string>, currentDirectory, files) => {
  let currentLine = Belt.Array.get(lines, 0)
  let rest = Belt.Array.sliceToEnd(lines, 1)
  let continue = parseTerminalOutput(rest)
  switch currentLine {
  | None => []
  | Some(str) if Js.String2.charAt(str, 0) == "$" => {
      let parts: array<string> = Js.String2.split(str, " ")
      let command = Belt.Array.get(parts, 1)

      switch command {
      | None => parseTerminalOutput(rest, currentDirectory, files)
      | Some("cd") => {
          let path = Belt.Array.get(parts, 2)
          switch path {
          | Some(path) if path == "/" =>
            Belt.Array.concat([Cd({path, fullpath: "/"})], continue("", files))
          | Some(path) if path == ".." =>
            let dirParts = Js.String2.split(currentDirectory, "/")
            let newDirectory =
              dirParts
              ->Belt.Array.slice(~offset=0, ~len=Belt.Array.length(dirParts) - 1)
              ->Belt.Array.joinWith("/", a => a)

            let fullpath = Js.String2.length(newDirectory) == 0 ? "/" : newDirectory
            Belt.Array.concat([Cd({path, fullpath})], continue(newDirectory, files))
          | Some(path) =>
            let newDirectory = currentDirectory ++ "/" ++ path
            Belt.Array.concat([Cd({path, fullpath: newDirectory})], continue(newDirectory, files))

          | None => continue(currentDirectory, files)
          }
        }

      | Some("ls") => Belt.Array.concat([Ls], continue(currentDirectory, files))

      | Some(_) => continue(currentDirectory, files)
      }
    }

  | Some(str) if Js.String2.slice(str, ~from=0, ~to_=3) == "dir" => {
      let parts: array<string> = Js.String2.split(str, " ")
      switch Belt.Array.get(parts, 1) {
      | None => continue(currentDirectory, files)
      | Some(path) => {
          let dir = [
            Directory({
              path: currentDirectory ++ "/" ++ path,
            }),
          ]
          Belt.Array.concat(dir, continue(currentDirectory, files))
        }
      }
    }

  | Some(str) if Belt.Int.fromString(Js.String2.charAt(str, 0)) != None => {
      let parts = Js.String2.split(str, " ")
      switch parts {
      | [sizeStr, path] => {
          let size = Belt.Int.fromString(sizeStr)
          switch size {
          | Some(size) => {
              let file = [
                File({
                  size,
                  path,
                  fullpath: currentDirectory ++ "/" ++ path,
                }),
              ]
              Belt.Array.concat(file, continue(currentDirectory, files))
            }

          | _ => continue(currentDirectory, files)
          }
        }

      | _ => continue(currentDirectory, files)
      }
    }

  | Some(other) => {
      Js.log2("Other", other)
      []
    }
  }
}

let rec getDirectoryTotals = (directory, commands) => {
  let command = Belt.Array.get(commands, 0)
  let rest = Belt.Array.sliceToEnd(commands, 1)

  switch command {
  | Some(File(file)) =>
    switch Js.String2.startsWith(file.fullpath, directory) {
    | true => file.size + getDirectoryTotals(directory, rest)
    | false => getDirectoryTotals(directory, rest)
    }

  | None => 0
  | _ => getDirectoryTotals(directory, rest)
  }
}

let totalDiskSpace = 70000000
let updateSize = 30000000
let data: array<string> = Js.String2.split(DaySevenInput.data, "\n")

let rec findSmallest = (items, smallest: int) => {
  let size = switch Belt.Array.get(items, 0) {
  | Some(_, size) => size
  | _ => smallest
  }

  let rest = Belt.Array.sliceToEnd(items, 1)
  let smallest = size <= smallest ? size : smallest
  switch rest {
  | [] => smallest
  | rest => findSmallest(rest, smallest)
  }
}

let getData = () => {
  let commands = parseTerminalOutput(data, "", [])
  let files = Belt.Array.keep(commands, item =>
    switch item {
    | File(_) => true
    | _ => false
    }
  )

  let totalUsed = getDirectoryTotals("/", files)
  let freeSpace = totalDiskSpace - totalUsed
  let toDelete = updateSize - freeSpace

  let directoriesWithSize = Belt.Array.map(commands, directory => {
    switch directory {
    | Directory(dir) => (Some(dir.path), getDirectoryTotals(dir.path, commands))
    | _ => (None, 0)
    }
  })
  let belowTenThousand =
    directoriesWithSize
    ->Belt.Array.keep(((path, size)) =>
      switch path {
      | Some(_) if size <= 100000 => true
      | _ => false
      }
    )
    ->Belt.Array.reduce(0, (acc, (_, size)) => acc + size)

  let toRemove = directoriesWithSize->Belt.Array.keep(((path, size)) =>
    switch path {
    | Some(_) if size >= toDelete => true
    | _ => false
    }
  )

  let smallestToRemove = findSmallest(toRemove, totalDiskSpace)

  (belowTenThousand, smallestToRemove)
}
