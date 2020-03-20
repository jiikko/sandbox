import React, {
  useState,
  useCallback
} from 'react'

export const Counter: React.FC = () => {
  const [count, setCount] = useState(0)
  const handleClick = useCallback(() => {
    setCount(count + 1)
  }, [count])

  return (
    <div>
      <p>{count}</p>
      <button onClick={handleClick}>+1</button>
    </div>
  )
}
