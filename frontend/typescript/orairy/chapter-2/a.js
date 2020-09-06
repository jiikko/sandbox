['bbbbb', '3'].map(function (_a) {
    var length = _a.length;
    return length;
});
['abbbbb', '3'].map(function (_a) {
    var length = _a.length;
    return 1;
});
var a = [1, 4].map(function (x) { return (x + 2); });
var f = function (_a, _b) {
    var _c = _a === void 0 ? [1, 2] : _a, a = _c[0], b = _c[1];
    var c = (_b === void 0 ? { x: a + b } : _b).x;
    return a + b + c;
};
