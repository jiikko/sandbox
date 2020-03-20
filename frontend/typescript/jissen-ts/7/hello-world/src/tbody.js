"use strict";
exports.__esModule = true;
var React = require("react");
var tr_1 = require("./tr");
var Component = function (props) { return (<tbody>
    {props.rows.map(function (row) { return (<tr_1["default"] key={row.id} {...row}/>); })}
  </tbody>); };
exports["default"] = Component;
