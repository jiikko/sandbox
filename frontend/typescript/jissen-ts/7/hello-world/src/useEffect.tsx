import React, { useState, useEffect } from "react"

export const Component: React.FC = () => {
  const [count, setCount] = useState(0)
  useEffect(() => {
    const interval = setInterval(() => {
      setCount(count + 1)
    }, 1000)
    return () => clearInterval(interval)
  })

  return (
    <div>{count}</div>
  )
}
