import React from 'react';

class TextareaCounter extends React.Component {
  handleOnChange(env) {
    console.log(env)
  }
  render() {
    return <textarea
            value="ggggggg"
            onChange={this.handleOnChange}
           ></textarea>;
  }
}

export default TextareaCounter
