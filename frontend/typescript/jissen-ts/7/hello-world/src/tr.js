"use strict";
exports.__esModule = true;
var React = require("react");
var Component = function (props) { return (<tr>
    <th>{props.generation}</th>
    {props.answers.map(function (answer, i) { return (<td key={i}>{answer * 100 + "%"}</td>); })}
  </tr>); };
exports["default"] = Component;
