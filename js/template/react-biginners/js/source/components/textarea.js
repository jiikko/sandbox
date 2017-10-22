import React from 'react';

class Textarea extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      text: props.text,
      updateCounter: props.updateCounter,
    };
    this.handleOnChange = this.handleOnChange.bind(this);
  }
  handleOnChange(env) {
    var text = env.target.value;
    this.state.updateCounter(text.length);
    this.setState({ text: text });
  }
  render() {
    return(
        <textarea value={this.state.text} onChange={this.handleOnChange} />
    )
  }
}

export default Textarea
