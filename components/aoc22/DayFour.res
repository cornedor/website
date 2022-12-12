type from = int
type to = int
type range = (from, to)

type elfPair = (range, range)

let ensureInt = str => {
  let i = Belt.Int.fromString(str)
  switch i {
  | Some(i) => i
  | None => 0
  }
}
let stringRangeToTuple = (range: string): range => {
  let result = Js.String2.split(range, "-")

  switch result {
  | [a, b] => (ensureInt(a), ensureInt(b))
  | [a] => (ensureInt(a), 0)
  | _ => (0, 0)
  }
}

type parsedPairs =
  | ElfPair(elfPair)
  | None

let lineToElfPair = (line): parsedPairs => {
  let arr = Js.String2.split(line, ",")
  switch arr {
  | [elf1, elf2] => {
      let elf1Range = stringRangeToTuple(elf1)
      let elf2Range = stringRangeToTuple(elf2)
      ElfPair(elf1Range, elf2Range)
    }

  | _ => None
  }
}

let dataToElfPairs = data =>
  Js.String2.split(data, "\n")
  ->Belt.Array.map(lineToElfPair)
  ->Belt.Array.keepMap(pair =>
    switch pair {
    | ElfPair(item) => Some(item)
    | None => None
    }
  )

let findOverlap = (pair: elfPair) => {
  let (elf1, elf2) = pair
  let (start1, end1) = elf1
  let (start2, end2) = elf2

  let startFirst1 = start1 >= start2
  let endFirst1 = end1 <= end2
  let startFirst2 = start2 >= start1
  let endFirst2 = end2 <= end1

  switch (startFirst1, endFirst1, startFirst2, endFirst2) {
  | (true, true, _, _) => true
  | (_, _, true, true) => true
  | _ => false
  }
}

let getFullOverlapsInSchema = () => {
  let schema = dataToElfPairs(DayFourInput.data)
  Belt.Array.keep(schema, findOverlap)->Belt.Array.length
}

let partialOverlap = (range1, range2) => {
  let (start1, end1) = range1
  let (start2, end2) = range2
  let isStartInRange = start1 >= start2 && start1 <= end2
  let isEndInRange = end1 >= start2 && end1 <= end2

  isStartInRange || isEndInRange
}
let findPartialOverlap = (pair: elfPair) => {
  let (elf1, elf2) = pair
  partialOverlap(elf1, elf2) || partialOverlap(elf2, elf1)
}

let getPartialOverlapsInSchema = () => {
  let schema = dataToElfPairs(DayFourInput.data)
  Belt.Array.keep(schema, findPartialOverlap)->Belt.Array.length
}

exception Incorrect_Result(int)

// Test added after answers were found
let test = () => {
  if getFullOverlapsInSchema() != 450 {
    raise(Incorrect_Result(getPartialOverlapsInSchema()))
  }

  if getPartialOverlapsInSchema() != 837 {
    raise(Incorrect_Result(getPartialOverlapsInSchema()))
  }
}

test()
