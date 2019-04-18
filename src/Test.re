module Dbc = Yawaramin__Dbc;

let integerDiv(num, denom) = {
  Dbc.pre(~message={j|$num >= $denom|j}, num >= denom);
  Dbc.pre(~message={j|$denom != 0|j}, denom != 0);
  let ensure = Dbc.post(~message={j|resultNum >= (num - 1) && resultNum <= num|j}, (. result) => {
    let resultNum = result * denom;
    resultNum >= (num - 1) && resultNum <= num;
  });

  ensure(. num / denom);
};

2 |> integerDiv(3) |> Js.log;
