import React from 'react';
import logo from './logo.svg';
import './App.css';
import { BrowserRouter as Router, Route } from "react-router-dom";

function App() {
  return (
    <div className="App">
      <header className="App-header">
        <img src={logo} className="App-logo" alt="logo" />
        <Router>
          <p>Learn React1</p>
          <Route path='/a' >
            <p>ffo</p>
          </Route>
        </Router>
      </header>
    </div>
  );
}

export default App;
