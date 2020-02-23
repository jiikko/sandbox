import React from 'react';
import ReactDOM from 'react-dom';
import './index.css';
import App from './App';
import * as serviceWorker from './serviceWorker';


class Parent extends React.Component {
	render() {
		return (
			<div>
				<div>
					<Child/>
					<Child/>
					<Child/>
				</div>
				<button>Clear A</button>
			</div>
		)
	}
}

class Child extends React.Component {
	state = { a: 0, b: 0 }
	up = () => {
		this.setState(s => ({a: s.a + 1, b: s.b + 1}))
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

ReactDOM.render(
	<Parent/>,
	document.getElementById("root")
)

// If you want your app to work offline and load faster, you can change
// unregister() to register() below. Note this comes with some pitfalls.
// Learn more about service workers: https://bit.ly/CRA-PWA
serviceWorker.unregister();
