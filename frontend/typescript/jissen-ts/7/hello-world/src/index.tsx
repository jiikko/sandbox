import React, {
} from 'react'
import { rows } from './data'
import Thead from './thead'
import Tbody from './tbody'
import { Counter } from './useStateComponent'
import { Component as Memo } from './useMemo'
import { Container as UseCallbackComponent } from './useCallback'
import { Component as UseEffectComponent } from "./useEffect"
import { Component as UseRefComponent } from "./useRef"
import { Component as UseReducerComponent } from "./useReducer"
import { Container as TryReducer } from "./tryReducer"

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
    <UseEffectComponent />
    <UseRefComponent />
    <UseReducerComponent />
    <TryReducer />
  </div>
)

ReactDOM.render(<Component />, document.getElementById('root'));
