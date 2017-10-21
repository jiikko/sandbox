import React from 'react';

class TextareaCounter extends React.Component {
  constructor(props) {
    super(props);
    this.state = { text: 'default value' };
    // https://qiita.com/cubdesign/items/ee8bff7073ebe1979936#%E8%A7%A3%E6%B1%BA%E7%AD%96%EF%BC%91
    this.handleOnChange = this.handleOnChange.bind(this);
  }
  handleOnChange(env) {
    console.log(env.target.value);
    this.setState = { text: env.target.value };
  }
  render() {
    return <textarea
            onChange={this.handleOnChange}
           ></textarea>;
  }
}

export default TextareaCounter
