[@bs.new] external typeError: string => exn = "TypeError";

let noDescription = "(no description)";

let error(message) =
  {j|Failed assertion: $message|j} |> typeError |> raise;

let pre(~message=noDescription, condition) =
  if (!condition) error(message);

let post(~message=noDescription, func) = (. result) =>
  if (func(. result)) result else error(message);
