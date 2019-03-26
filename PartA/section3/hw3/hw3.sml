
(* Author: Mustafa Jamal *)
(* Coursera Programming Languages, Homework 3 *)

exception NoAnswer

datatype pattern = Wildcard
		 | Variable of string
		 | UnitP
		 | ConstP of int
		 | TupleP of pattern list
		 | ConstructorP of string * pattern

datatype valu = Const of int
	      | Unit
	      | Tuple of valu list
	      | Constructor of string * valu

fun g f1 f2 p =
    let 
	val r = g f1 f2 
    in
	case p of
	    Wildcard          => f1 ()
	  | Variable x        => f2 x
	  | TupleP ps         => List.foldl (fn (p,i) => (r p) + i) 0 ps
	  | ConstructorP(_,p) => r p
	  | _                 => 0
    end

(**** for the challenge problem only ****)

datatype typ = Anything
	     | UnitT
	     | IntT
	     | TupleT of typ list
	     | Datatype of string

(**** you can put all your code here ****)

(* 1. only_capitals that takes a string list and returns a string list that has 
	onlythe strings in the argument that start with an uppercase letter. *)
fun only_capitals sList =
		List.filter (fn s => Char.isUpper(String.sub(s, 0))) sList

(* 2. longest_string1 that takes a string list and returns the longest string in thelist. *)
fun longest_string1 sList =
		foldl (fn (s, acc) => if (String.size s > String.size acc) then s else acc)
			  "" sList

(* 3. Write a function longest_string2 that is exactly like longest_string1 
	except in the case of tiesit returns the string closest to the end of the list. *)
fun longest_string2 sList =
		foldl (fn (s, acc) => if (String.size s < String.size acc) then acc else s)
			  "" sList

(* 4. Write functions longest_string_helper, longest_string3, and longest_string4 *)
fun longest_string_helper f sList =
		foldl (fn (s, acc) => if f(String.size s, String.size acc) then s else acc) 
			   "" sList
	
val longest_string3 = longest_string_helper (fn (len1, len2) => (len1 > len2))

val longest_string4 = longest_string_helper (fn (len1, len2) => (len1 >= len2))

(* 5. longest_capitalized that takes a string list and returns the longest string *)
val longest_capitalized = longest_string1 o only_capitals

(* 6. rev_string that takes a string and returns the string that is the same characters inreverse order. *)
val rev_string = implode o rev o explode

(* 7. Write a function first_answer of type (’a -> ’b option) -> ’a list -> ’b *)
fun first_answer f aList =
		case aList of
			[] => raise NoAnswer
		  | (a::aList') => 	case f a of
		  						NONE => first_answer f aList'
							  | SOME a => a

(* 8. all_answers of type (’a -> ’b list option) -> ’a list -> ’b list option. *)
fun all_answers f aList =
		let
		  	fun helper aList acc = 
			  	case aList of
			   		[] => SOME acc
				  | (a::aList') => case f a of
				  					NONE => NONE
			  					  | SOME ans => helper aList' (acc@ans)
		in
		  helper aList []
		end

(* 9. a *)
val count_wildcards = g (fn () => 1) (fn _ => 0)

(* 9. b *)
val count_wild_and_variable_lengths = g (fn () => 1) String.size

(* 9. c *)
fun count_some_var (s, p) = g (fn () => 0) (fn x => if x = s then 1 else 0) p

(* 10. check_pat that takes a pattern and returns true
	if and only if all the variablesappearing in the pattern are distinct from each other. *)
fun check_pat p = 
		let
		  	fun all_strings p =
			  	case p of 
				  	Variable x                    => [x]
				  | TupleP ps => foldl (fn (p, i) => all_strings p@i) [] ps
				  | ConstructorP (_, p)           => all_strings p
				  | _                             => []
			fun no_repeates strs = 
				case strs of
					[]       => true
				  | (s::strs') => not (List.exists (fn x => s = x) strs') andalso no_repeates strs'
		in
			no_repeates (all_strings p)
		end

(* 11. match that takes a valu * pattern and returns a (string * valu) list option. *)
fun match (v, p) =
  	case (v, p) of
      (_, Wildcard) => SOME []
    | (sv, Variable sp) => SOME [(sp,sv)]
    | (Unit, UnitP) => SOME []
    | (Const iv, ConstP ip) => if iv = ip then SOME [] else NONE
    | (Tuple tv, TupleP tp) => if List.length tv = List.length tp
                               then all_answers match (ListPair.zip(tv, tp))
                               else NONE
    | (Constructor (s1,cv), ConstructorP (s2,cp)) => if s1 = s2
                                                     then match (cv,cp)
                                                     else NONE
    | (_, _) => NONE

(* 12. first_match that takes a value and a list of patterns and returns a(string * valu) list option *)
fun first_match v ps = 
		SOME (first_answer (fn p => match (v, p)) ps)
		handle NoAnswer => NONE
