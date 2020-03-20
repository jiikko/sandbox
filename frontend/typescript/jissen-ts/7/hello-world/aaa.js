"use strict";
exports.__esModule = true;
var React = require("react");
var Child = function (props) { return (<div>{props.children}</div>); };
var Parent = function (props) { return (<Child>
  {props.childLabel}
  </Child>); };
