'use strict';

var _react = require('react');

var _react2 = _interopRequireDefault(_react);

var _reactDom = require('react-dom');

var _reactDom2 = _interopRequireDefault(_reactDom);

var _logo = require('./components/logo');

var _logo2 = _interopRequireDefault(_logo);

var _textarea_counter = require('./components/textarea_counter');

var _textarea_counter2 = _interopRequireDefault(_textarea_counter);

function _interopRequireDefault(obj) { return obj && obj.__esModule ? obj : { default: obj }; }

_reactDom2.default.render(_react2.default.createElement(
  'div',
  null,
  _react2.default.createElement(
    'h1',
    null,
    _react2.default.createElement(_logo2.default, null),
    ' \u30A2\u30D7\u30EA\u30B1\u30FC\u30B7\u30E7\u30F3\u306B\u3088\u3046\u3053\u305D\uFF01'
  ),
  _react2.default.createElement(_textarea_counter2.default, { text: 'hhhhhhhhhhhhh' }),
  _react2.default.createElement('br', null)
), document.getElementById('app'));