#if defined NODE_ENV && NODE_ENV = "production" then
#else
external typeError : string -> exn = "TypeError" [@@bs.new]
let error message  = message |> typeError |> raise
#end

let contract ~pre ~post body =
#if defined NODE_ENV && NODE_ENV = "production" then
  ignore pre;
  ignore post;
#else
  pre |> Js.Array.forEach (fun (message, condition) ->
    if not condition then error {j|Precondition broken: $message|j});

  (post body [@bs])
  |> Js.Array.forEach (fun (message, condition) ->
    if not condition then error {j|Postcondition broken: $message|j});
#end
  body

let noPost () = fun [@bs] _ -> [||]

let pre ?(message="(no description)") condition =
#if defined NODE_ENV && NODE_ENV = "production" then
  ignore message;
  ignore condition
#else
  if not condition then error {j|Precondition broken: $message|j}
#end

let post ?(message="(no description)") func = fun [@bs] result ->
#if defined NODE_ENV && NODE_ENV = "production" then
  ignore message;
  ignore func;
  result
#else
  if (func result) [@bs] then result
  else error {j|Postcondition broken: $message|j}
#end
