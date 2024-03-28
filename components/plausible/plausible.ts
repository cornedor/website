interface Options {
  callback?: () => void
  props?: object
  revenue?: { currency: string; amount: number }
}

export function plausible(event: string): void
export function plausible(event: string, options: Options): void
export function plausible() {
  plausible.q.push(arguments)
}

plausible.q = [] as object[]

if (typeof window !== 'undefined') {
  // @ts-ignore
  window.plausible = plausible
}
