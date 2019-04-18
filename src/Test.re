module Dbc = Yawaramin__Dbc;

let safeDiv(num, denom) = {
  Dbc.pre(~message="num >= denom", num >= denom);
  Dbc.pre(~message="denom != 0", denom != 0.);
  Dbc.post(
    ~message="safeDiv(num, denom) *. denom == num",
    (. result) => result *. denom == num,
  )(. num /. denom);
};

2. |> safeDiv(3.) |> Js.log;
