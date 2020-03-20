import React, {
} from 'react'
import { rows } from './data'
import Thead from './thead'
import Tbody from './tbody'
import { Counter } from './useStateComponent'
import { Component as Memo } from './useMemo'
import { Container as UseCallbackComponent } from './useCallback'

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
    <UseCallbackComponent />
  </div>
)

ReactDOM.render(<Component />, document.getElementById('root'));
