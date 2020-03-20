import React, {
  useState,
  useCallback
} from 'react'
import { rows } from './data'
import Thead from './thead'
import Tbody from './tbody'

import ReactDOM from 'react-dom';

const Counter: React.FC = () => {
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

const Component: React.FC = () => (
  <div>
    <h1>tyousa</h1>
    <table>
      <Thead />
      <Tbody rows={rows} />
    </table>
    <Counter />
  </div>
)

// export default Component

ReactDOM.render(<Component />, document.getElementById('root'));
