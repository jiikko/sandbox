// @flow

import React from 'react';
import ReactDOM from 'react-dom';
import Heading from './heading';

export class Render {
  constructor(targetId: string) {
    const target = document.getElementById(targetId);
    if (target != null) {
      this.render(target);
    }
  }

  render(target: HTMLElement) {
    ReactDOM.render(<Heading name="Nekomimi" />, target);
  }
}

export default new Render('frontend');
