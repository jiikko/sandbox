import * as React from "react"

type Props = {
  children?: React.ReactNode
}

const Child = (props: Props) => (
  <div>{props.children}</div>
)

const Parent = (props: Props & { childLabel: string }) => (
  <Child>
  {props.childLabel}
  </Child>
)
