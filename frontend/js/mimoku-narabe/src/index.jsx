import React from 'react';
import ReactDOM from 'react-dom';
import { Provider } from "react-redux";
import { createStore } from 'redux';
import { app } from './reducers';
import './index.css';
import { GameContainer } from "./containers";

const store = createStore(app);
ReactDOM.render(
  <Provider store={store}>
    <GameContainer />,
  </Provider>,
  document.getElementById('root')
);

