import React from 'react';
import logo from './logo.svg';
import './App.css';

import { createStore } from 'redux'

const counter = (state = 0, action) => {
  switch(action.type) {
    case 'INC':
      console.log('inc')
      return state + 1
    case 'DEC':
      console.log('dec')
      return state - 1
    default:
      console.log('not found')
      return state
  }
}
const Counter = ({value, onInc, onDec}) => (
    <div>
      <h1>{value}</h1>
      <button onClick={onInc}>+</button>
      <button onClick={onDec}>-</button>
    </div>
)

const store = createStore(counter)
   store.subscribe(() =>
       console.log(store.getState())
   )

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <p>
          Edit <code>src/App.js</code> and save to reload.
        </p>
        <a
          className="App-link"
          href="https://reactjs.org"
          target="_blank"
          rel="noopener noreferrer"
        >
          Learn React
        </a>

        <Counter value={store.getState()}
          onInc={() => store.dispatch({ type: 'INC' })}
          onDec={() => store.dispatch({ type: 'DEC' })}
        />
      </header>
    </div>
  );
}

export default App;
