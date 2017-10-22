'use strict';

Object.defineProperty(exports, "__esModule", {
  value: true
});

var _createClass = function () { function defineProperties(target, props) { for (var i = 0; i < props.length; i++) { var descriptor = props[i]; descriptor.enumerable = descriptor.enumerable || false; descriptor.configurable = true; if ("value" in descriptor) descriptor.writable = true; Object.defineProperty(target, descriptor.key, descriptor); } } return function (Constructor, protoProps, staticProps) { if (protoProps) defineProperties(Constructor.prototype, protoProps); if (staticProps) defineProperties(Constructor, staticProps); return Constructor; }; }();

var _react = require('react');

var _react2 = _interopRequireDefault(_react);

var _textarea = require('./textarea');

var _textarea2 = _interopRequireDefault(_textarea);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

function _classCallCheck(instance, Constructor) { if (!(instance instanceof Constructor)) { throw new TypeError("Cannot call a class as a function"); } }

function _possibleConstructorReturn(self, call) { if (!self) { throw new ReferenceError("this hasn't been initialised - super() hasn't been called"); } return call && (typeof call === "object" || typeof call === "function") ? call : self; }

function _inherits(subClass, superClass) { if (typeof superClass !== "function" && superClass !== null) { throw new TypeError("Super expression must either be null or a function, not " + typeof superClass); } subClass.prototype = Object.create(superClass && superClass.prototype, { constructor: { value: subClass, enumerable: false, writable: true, configurable: true } }); if (superClass) Object.setPrototypeOf ? Object.setPrototypeOf(subClass, superClass) : subClass.__proto__ = superClass; }

var TextareaCounter = function (_React$Component) {
  _inherits(TextareaCounter, _React$Component);

  function TextareaCounter(props) {
    _classCallCheck(this, TextareaCounter);

    var _this = _possibleConstructorReturn(this, (TextareaCounter.__proto__ || Object.getPrototypeOf(TextareaCounter)).call(this, props));

    _this.state = {
      text: props.text,
      text_length: props.text.length
    };
    _this.updateCounter = _this.updateCounter.bind(_this);
    return _this;
  }

  _createClass(TextareaCounter, [{
    key: 'updateCounter',
    value: function updateCounter(text_length) {
      this.setState({ text_length: text_length });
    }
  }, {
    key: 'render',
    value: function render() {
      return _react2.default.createElement(
        'div',
        null,
        _react2.default.createElement(_textarea2.default, { text: this.state.text, updateCounter: this.updateCounter }),
        _react2.default.createElement(
          'h1',
          null,
          this.state.text_length
        )
      );
    }
  }]);

  return TextareaCounter;
}(_react2.default.Component);

exports.default = TextareaCounter;