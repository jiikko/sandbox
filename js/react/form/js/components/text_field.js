import React from 'react';

class TextField extends React.Component {
  constructor(props) {
    super(props);
    this.state = {
      value: 'init text',
      buffer: 'これが書き込まれます'
    };
    this.handleClickSave = this.handleClickSave.bind(this);
    this.handleUpdateText = this.handleUpdateText.bind(this);
  }

  handleClickSave() {
    this.setState({ value: this.state.buffer });
  }
  handleUpdateText(env) {
    this.setState({ buffer: env.target.value });
  }

  render() {
    return(
      <div>
        テキストフィールド
        <div>
          <input type='text' value={this.state.buffer} onChange={this.handleUpdateText} />
        </div>
        <a onClick={this.handleClickSave} href='#'>save</a>
        <pre>{this.state.value}</pre>
      </div>
    )
  }
}

export default TextField;
