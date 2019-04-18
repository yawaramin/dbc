#if defined NODE_ENV && NODE_ENV = "production" then
#else
external typeError : string -> exn = "TypeError" [@@bs.new]
let error message  =
  {j|Failed assertion: $message|j} |> typeError |> raise
#end

let pre ?(message="(no description)") condition =
#if defined NODE_ENV && NODE_ENV = "production" then
  ignore message;
  ignore condition
#else
  if not condition then error message
#end

let post ?(message="(no description)") func = fun [@bs] result ->
#if defined NODE_ENV && NODE_ENV = "production" then
  ignore message;
  ignore func;
  result
#else
  if (func result) [@bs] then result else error message
#end
