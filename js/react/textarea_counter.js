// from react biginners
var TextAreaCounter = React.createClass({
  propTypes: {
    text: React.PropTypes.string,
  },
  getDefaultProps: function() {
    return {
      text: '',
    };
  },
  getInitialState: function() {
    console.log('init state')
    return {
      text: this.props.text,
    };
  },
  _textChange: function(ev) {
    console.log('changed text');
    this.setState({
      text: ev.target.value,
    });
  },
  render: function() {
    return React.DOM.div(null,
      React.DOM.textarea({
        value: this.state.text,
        onChange: this._textChange,
      }),
      React.DOM.h3(null, this.state.text.length)
    )
  }
});

ReactDOM.render(
  React.createElement(TextAreaCounter, {
    text: 'initialized string',
  }),
  document.getElementById("container")
)
