"use strict";
exports.__esModule = true;
var React = require("react");
var data_1 = require("./data");
var thead_1 = require("./thead");
var tbody_1 = require("./tbody");
var react_dom_1 = require("react-dom");
var Component = function () { return (<div>
    <h1>tyousa</h1>
    <table>
      <thead_1["default"] />
      <tbody_1["default"] rows={data_1.rows}/>
    </table>
  </div>); };
// export default Component
react_dom_1["default"].render(<Component />, document.getElementById('root'));
