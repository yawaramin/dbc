'use strict';

var dbc = require('./src/Yawaramin__Dbc.bs');

function pre(condition, message) {
  return dbc.pre(message, condition);
}

function post(func, message) {
  return dbc.post(message, func);
}

exports.pre = pre;
exports.post = post;
