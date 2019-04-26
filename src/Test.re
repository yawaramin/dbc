module Dbc = Yawaramin__Dbc;

let safeDiv(num, denom) = Dbc.contract(
  ~pre=[|
    ("num >= denom", num >= denom),
    ("denom != 0.", denom != 0.),
  |],
  ~post=(. result) => [|
    ("safeDiv(num, denom) *. denom == num", result *. denom == num),
  |],
  num /. denom,
);

let safeDivOld(num, denom) = {
  Dbc.pre(~message="num >= denom", num >= denom);
  Dbc.pre(~message="denom != 0.", denom != 0.);
  let ensure = Dbc.post(
    ~message="safeDiv(num, denom) *. denom == num",
    (. result) => result *. denom == num
  );

  ensure(. num /. denom);
};

let makeUser(name, age) = Dbc.contract(
  ~pre=[|("age >= 13", age >= 13)|],
  ~post=Dbc.noPost(),
  {"name": name, "age": age},
);

let () = {
  2. |> safeDiv(3.) |> Js.log;
  2. |> safeDivOld(3.) |> Js.log;
  13 |> makeUser("Bob") |> Js.log;
};
