/** Helpers for programming in a design-by-contract style. Here's an
    example usage:

    {[module Dbc = Yawaramin__Dbc;

let integerDiv(num, denom) = {
  Dbc.pre(~message={j|$num >= $denom|j}, num >= denom);
  Dbc.pre(~message={j|$denom != 0|j}, denom != 0);
  let ensure = Dbc.post(~message={j|result * $denom == $num|j}, (. result) =>
    result * denom == num
  );

  ensure(. num / denom);
}]} */

/** [pre(~message, condition)] throws a [TypeError] with the given
    [message] if the [condition] doesn't hold. Otherwise it does nothing. */
let pre: (~message: string=?, bool) => unit;

/** [post(~message, func)] returns a function which can be used to check
    a postcondition, i.e. a requirement that the function result must
    ensure. This requirement on the result is specified by [func]. If the
    requirement is not met, will throw a [TypeError] with the given
    [message]. */
let post: (~message: string=?, (. 'a) => bool) => (. 'a) => 'a;
