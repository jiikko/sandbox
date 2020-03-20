import React, {
} from 'react'
import { rows } from './data'
import Thead from './thead'
import Tbody from './tbody'
import { Counter } from './useStateComponent'
import { Component as Memo } from './useMemo'

import ReactDOM from 'react-dom';

const Component: React.FC = () => (
  <div>
    <h1>tyousa</h1>
    <table>
      <Thead />
      <Tbody rows={rows} />
    </table>
    <Counter />
    <Memo />
  </div>
)

// export default Component

ReactDOM.render(<Component />, document.getElementById('root'));
