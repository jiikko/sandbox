import React, { useReducer } from "react"
type State = {
  count: number
  unit: string
}
const initialState: State = {
  count: 0,
  unit: "pt"
}

function reducer(state: State, action: any): State {
  switch(action.type) {
    case "increment":
      return { ...state, count: state.count + 1 }
    case "decrement":
      return { ...state, count: state.count - 1 }
    default: 
      throw new Error()
  }
}

export const Component: React.FC = () => {
  const [state, dispatch] = useReducer(reducer, initialState)
  return (
    <>
      Count: {state.count}
      <button onClick={() => dispatch({ type: "increment" })}> + </button>
      <button onClick={() => dispatch({ type: "decrement" })}>-</button>
    </>
  )
}
