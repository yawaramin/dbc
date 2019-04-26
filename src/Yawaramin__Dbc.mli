(** Helpers for programming in a design-by-contract style. See [Test.re]
    for an example usage. *)

(** [contract ~pre ~post body] defines a function with a [body] and an
    array of [pre]conditions as well as a checker for an array of
    [post]conditions. *)
val contract :
  pre:(string * bool) array ->
  post:('a -> (string * bool) array [@bs]) ->
  'a ->
  'a

(** [noPost ()] creates a checker for an empty array of postconditions,
    in other words it lets you say there are no postconditions. *)
val noPost : unit -> ('a -> (string * bool) array [@bs])

(* The following shouldn't be needed by ReasonML/BuckleScript consumers
   because of the better-designed [contract] function. *)

(** [pre(~message, condition)] throws a [TypeError] with the given
    [message] if the [condition] doesn't hold. Otherwise it does nothing. *)
val pre : ?message:string -> bool -> unit

(** [post(~message, func)] returns a function which can be used to check
    a postcondition, i.e. a requirement that the function result must
    ensure. This requirement on the result is specified by [func]. If the
    requirement is not met, will throw a [TypeError] with the given
    [message]. *)
val post : ?message:string -> ('a -> bool [@bs]) -> ('a -> 'a [@bs])
