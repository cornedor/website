type crate = Tag(string) | Empty
type stack = list<crate>
type stacks = array<stack>

type instruction = Move(int, int, int)
type instructions = list<instruction>

type crateMoverVersion = CM9000 | CM9001

let margin = 1
let blockSize = 3
let countStacks = lines =>
  switch lines {
  | [] => 0
  | lines => (Js.String2.length(lines[0]) + margin) / (blockSize + margin)
  }

let rec readLine = (line): array<crate> => {
  let chunk = Js.String2.slice(line, ~from=0, ~to_=blockSize + margin)
  let rest = Js.String2.sliceToEnd(line, ~from=blockSize + margin)
  let emptyStack: array<crate> = []

  switch Js.String2.length(chunk) {
  | 0 => emptyStack
  | _ => {
      let bracket = Js.String2.charAt(chunk, 0)
      let char = Js.String2.charAt(chunk, 1)

      switch (bracket, char) {
      | ("[", char) => Belt.Array.concat([Tag(char)], readLine(rest))
      | (" ", " ") => Belt.Array.concat([Empty], readLine(rest))
      | _ => emptyStack
      }
    }
  }
}

let rec readLines = (lines, emptyStacks: array<stack>, count): (stacks, int) => {
  switch lines {
  | [] => ([], count)
  | lines => {
      let parsedLine = readLine(lines[0])

      switch parsedLine {
      | [] => (emptyStacks, count)
      | _ => {
          let data = Belt.Array.mapWithIndex(parsedLine, (index, crate) => {
            let rest = switch Belt.Array.get(emptyStacks, index) {
            | None => list{}
            | Some(r) => r
            }
            let stack: stack = switch crate {
            | Empty => rest
            | crate => list{crate, ...rest}
            }
            stack
          })
          let (newStacks, count) = readLines(Belt.Array.sliceToEnd(lines, 1), data, count + 1)
          (newStacks, count)
        }
      }
    }
  }
}

let rec readInstructions = (lines: array<string>) => {
  let line = Belt.Array.get(lines, 0)
  let rest = Belt.Array.sliceToEnd(lines, 1)
  switch line {
  | None => list{}
  | Some(line) => {
      let tokens = Js.String2.split(line, " ")
      let instructionTag = Belt.Array.get(tokens, 0)
      switch instructionTag {
      | Some("move") => {
          let amountStr = Belt.Array.get(tokens, 1)
          let fromStr = Belt.Array.get(tokens, 3)
          let toStr = Belt.Array.get(tokens, 5)
          let action = switch (amountStr, fromStr, toStr) {
          | (Some(amountStr), Some(fromStr), Some(toStr)) => {
              let amount = Belt.Int.fromString(amountStr)
              let from = Belt.Int.fromString(fromStr)
              let to_ = Belt.Int.fromString(toStr)

              switch (amount, from, to_) {
              | (Some(amount), Some(from), Some(to_)) => Move(amount, from - 1, to_ - 1)
              | _ => Move(0, 0, 0)
              }
            }

          | _ => Move(0, 0, 0)
          }
          list{action, ...readInstructions(rest)}
        }

      | _ => list{}
      }
    }
  }
}

let getStack = (stacks: stacks, index: int) => {
  let stack = Belt.Array.get(stacks, index)
  switch stack {
  | Some(stack) => stack
  | None => list{}
  }
}

let grabFromStack = (stack: stack, amount: int) => {
  let emptyStack: stack = list{}
  switch Belt.List.splitAt(stack, amount) {
  | Some(grabbed, rest) => (grabbed, rest)
  | _ => (emptyStack, emptyStack)
  }
}

let sortGrabbedCrates = (stack: stack, version) =>
  switch version {
  | CM9000 => Belt.List.reverse(stack)
  | CM9001 => stack
  }

let rec applyInstructions = (stacks: stacks, instructions: instructions, crateMoverVersion) => {
  switch instructions {
  | list{instruction, ...rest} =>
    switch instruction {
    | Move(amount, from, to_) => {
        let stack = getStack(stacks, from)
        let stackTo = getStack(stacks, to_)
        let (grabbed, restStack) = grabFromStack(stack, amount)
        let newStackTo: stack = Belt.List.concat(
          sortGrabbedCrates(grabbed, crateMoverVersion),
          stackTo,
        )
        let newStacks = Belt.Array.mapWithIndex(stacks, (index, stack) => {
          switch index {
          | _ if index == to_ => newStackTo
          | _ if index == from => restStack
          | _ => stack
          }
        })
        applyInstructions(newStacks, rest, crateMoverVersion)
      }
    }

  | _ => stacks
  }
}

let revertStacks = (stacks: stacks) => {
  Belt.Array.map(stacks, stack => {
    Belt.List.reverse(stack)
  })
}

let initStacks = (lines, crateMoverVersion) => {
  let count = countStacks(lines)
  let emptyStacks: stacks = Belt.Array.makeBy(count, _ => list{})
  let (stacks, parsedLines) = readLines(lines, emptyStacks, 0)
  let stacks = revertStacks(stacks)

  let instructions = readInstructions(Belt.Array.sliceToEnd(lines, parsedLines + 2))

  let result = applyInstructions(stacks, instructions, crateMoverVersion)

  (result, instructions)
}
