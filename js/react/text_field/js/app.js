import React from 'react';
import ReactDOM from 'react-dom';
import TextField from './components/text_field';

ReactDOM.render(
  <div>
    <h1>
      アプリケーションにようこそ！
      <TextField />
    </h1>
  </div>
  ,
  document.getElementById('app')
);
