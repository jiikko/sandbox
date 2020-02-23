import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import * as serviceWorker from './serviceWorker';


class Child extends React.Component {
  state = { a: 0, b: 0 }
  constructor(props) {
    super(props)
    props.onInit(this)
  }
  up = () => {
    this.setState(s => ({a: s.a + 1, b: s.b + 1}))
  }
  clear() {
    this.setState({ a: 0 })
  }

  render() {
    return (
      <div>
        {this.state.a},
        {this.state.b}
        <button onClick={this.up}>Up</button>
      </div>
    )
  }
}

class Parent extends React.Component {
  children = []
  clear = () => {
    this.children.forEach(c => c.clear())
  }
  addChildRef = (instance) => {
    this.children.push(instance)
  }

  render() {
    return (
      <div>
        <div>
          <Child onInit={this.addChildRef} />
          <Child onInit={this.addChildRef} />
          <Child onInit={this.addChildRef} />
        </div>
        <button onClick={this.clear}>Clear A</button>
      </div>
    )
  }
}

ReactDOM.render(
  <Parent/>,
  document.getElementById("root")
)

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
