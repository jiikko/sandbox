import React, {
  useState,
  useCallback,
  useMemo
} from "react"

export const Component: React.FC = () => {
  const [count, setCount] = useState(0)
  const double = useMemo(() => count * 2, [count])
  const doubleWithUnit = useMemo(() => `${double} pt`, [double])
  const handleClick = useCallback(() => {
    setCount(prev => prev + 1)
  }, [])
  return (
    <div>
      <p>count: {count}</p>
      <p>double: {double}</p>
      <p>doubleWithUnit: {doubleWithUnit}</p>
      <button onClick={handleClick}>+1</button>
    </div>
  )
}
