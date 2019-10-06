(** DSL to define sets that are defined by a membership : 'a -> bool function. *)

open! Stdune

module Ast : sig
  type 'a t =
    | Element of 'a
    | Compl of 'a t
    | Standard
    | Union of 'a t list
    | Inter of 'a t list

  val diff : 'a t -> 'a t -> 'a t

  val inter : 'a t list -> 'a t

  val compl : 'a t -> 'a t

  val union : 'a t list -> 'a t

  val not_union : 'a t list -> 'a t

  val decode : 'a Dune_lang.Decoder.t -> 'a t Dune_lang.Decoder.t

  val to_dyn : 'a Dyn.Encoder.t -> 'a t Dyn.Encoder.t
end

type t

val to_dyn : t -> Dyn.t

val decode : t Dune_lang.Decoder.t

val empty : t

(** Always return [true] *)
val true_ : t

(** Always return [false] *)
val false_ : t

val exec : t -> standard:t -> string -> bool

val filter : t -> standard:t -> string list -> string list

val of_glob : Glob.t -> t

val of_pred : (string -> bool) -> t

val compl : t -> t

val union : t list -> t

val diff : t -> t -> t

val of_string_set : String.Set.t -> t
