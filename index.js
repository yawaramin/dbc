'use strict';

var dbc = require('./src/Yawaramin__Dbc.bs');

function contract(body, pre, post) {
  return dbc.contract(
    pre || [],
    post || (function() { return []; }),
    body
  );
}

function pre(condition, message) {
  return dbc.pre(message, condition);
}

function post(func, message) {
  return dbc.post(message, func);
}

exports.contract = contract;
exports.pre = pre;
exports.post = post;
