import React from 'react';
import Textarea from './textarea';

class TextareaCounter extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      text: props.text,
      text_length: props.text.length,
    };
    this.updateCounter = this.updateCounter.bind(this);
  }
  updateCounter(text_length) {
    this.setState({ text_length: text_length });
  }
  render() {
    return(
      <div>
        <Textarea text={this.state.text} updateCounter={this.updateCounter} />
        <h1>{this.state.text_length}</h1>
      </div>
    )
  }
}

export default TextareaCounter
