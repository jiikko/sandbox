import React from 'react';
import logo from './logo.svg';
import { withRouter } from 'react-router'
import './App.css';
import { BrowserRouter, Link, Route, Switch } from "react-router-dom";

const About = () => <h1 className='testTarget'>これです</h1>

function App() {
  return (
    <div className="App">
      <p>Learn React1({1 + 3})</p>
      <BrowserRouter>
        <Switch>
          <Route path='/a' component={About} exact />
        </Switch>
      </BrowserRouter>
    </div>
  );
}

export default App;
