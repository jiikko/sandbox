'use strict';

import React from 'react';
import ReactDOM from 'react-dom';
import Logo from './components/logo';
import TextareaCounter from './components/textarea_counter';

ReactDOM.render(
  <div>
    <h1>
    <Logo /> アプリケーションにようこそ！
    </h1>
    <TextareaCounter text={'hhhhhhhhhhhhh'} />
    <br />
  </div>
  ,
  document.getElementById('app')
);
