import * as creators from "./tryReducer/actionCreators"
import * as types from "./tryReducer/actionTypes"

import React, {
  useReducer,
  useMemo,
  useCallback
} from "react"
import { increment, decrement } from "./tryReducer/actionCreators"

type State = {
  count: number
  unit: string
}

function initialState(injects?: Partial<State>): State {
  return {
    count: 0,
    unit: "pt",
    ...injects
  }
}

type ReturnTypes<T> = { [K in keyof T]: T[K] extends (...args: any[]) => any ? ReturnType<T[K]> : never }
type Unbox<T> = T extends { [K in keyof T]: infer U } ? U : never
type T = Unbox<{ a: 'A'; b: 'B'; c: 'C' }>

export type CreatorsToActions<T> = Unbox<ReturnTypes<T>>
type Actions = CreatorsToActions<typeof creators>

function reducer(state: State, action: Actions): State {
  switch (action.type) {
    case types.INCREMENT:
      return { ...state, count: state.count + 1 }
    case types.DECREMENT:
      return { ...state, count: state.count - 1 }
    case types.SET_COUNT:
      return { ...state, count: action.payload.amount }
    default:
      throw new Error()
  }
}

export function increment() {
  return { type: types.INCREMENT }
}
export function decrement() {
  return { type: types.DECREMENT }
}
export function setCount(amount: number) {
  return { type: types.SET_COUNT, payload: { amount } }
}

type Props = {
  countLabel: string
  onClickIncrement: () => void
  onClickDecrement: () => void
}

const Component: React.FC<Props> = props => (
  <div>
    Count: {props.countLabel}
    <button onClick={props.onClickIncrement}>+</button>
    <button onClick={props.onClickDecrement}>-</button>
  </div>
)

export const Container: React.FC = () => {
  const [state, dispatch] = useReducer(reducer, initialState({ count: 0 }))
  const countLabel = useMemo(() => `${state.count} ${state.unit}`, [state])
  const onClickIncrement = useCallback(() => dispatch(increment()),[])
  const onClickDecrement = useCallback(() => dispatch(decrement()), [])
  return (
    <Component
      countLabel={countLabel}
      onClickIncrement={onClickIncrement}
      onClickDecrement={onClickDecrement}
    />
  )
}
