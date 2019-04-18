module Dbc = Yawaramin__Dbc;

let safeDiv(num, denom) = {
  Dbc.pre(~message={j|num >= denom|j}, num >= denom);
  Dbc.pre(~message={j|denom != 0|j}, denom != 0.);
  Dbc.post(
    ~message={j|safeDiv(num, denom) *. denom == num|j},
    (. result) => result *. denom == num,
  )(. num /. denom);
};

2. |> safeDiv(3.) |> Js.log;
