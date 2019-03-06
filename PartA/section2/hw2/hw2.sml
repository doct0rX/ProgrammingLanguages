(* Dan Grossman, Coursera PL, HW2 Provided Code *)

(* if you use this function to compare two strings (returns true if the same
   string), then you avoid several of the functions in problem 1 having
   polymorphic types that may be confusing *)
fun same_string(s1 : string, s2 : string) =
    s1 = s2

(* 
 * put your solutions for problem 1 here 
 *)

(* (a) Write a function all_except_option, which takes a string and a string list. Return NONE if thestring is not in the list,
   else return SOME lst where lst is identical to the argument list except the stringis not in it. You may assume the string is 
   in the list at most once. Use same_string, provided to you,to compare strings. Sample solution is around 8 lines. *)
fun all_except_option(str, xs) = 
    let 
        fun two_lists(current_list, previous_list) = 
          case current_list
            of [] => NONE
            | x::xs' => if same_string(str, x)
                        then SOME (previous_list@xs')
                        else two_lists(xs', previous_list@[x])
    in
      two_lists(xs, [])
    end

(* (b) Write a function get_substitutions1, which takes a string list list (a list of list of strings, thesubstitutions)
 and a string s and returns a string list. The result has all the strings that are insome list in substitutions that also has s, 
 but s itself should not be in the result. Example:get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred")
 (* answer: ["Fredrick","Freddie","F"] *)Assume each list in substitutions has no repeats.
 The result will have repeats if s and another string areboth in more than one list in substitutions.
 Example:get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff")
 (* answer: ["Jeffrey","Geoff","Jeffrey"] *)  *)
fun get_substitutions1(xss, str) =
  let
    fun track_subs(str, xss, list_add) =
      case xss
        of [] => list_add
        | xs::xss' => case all_except_option(str, xs)
          of NONE => track_subs(str, xss', list_add)
          | SOME x => track_subs(str, xss',list_add@x)
  in
    track_subs(str, xss, [])
  end

(* (c) Write a function get_substitutions2, which is like get_substitutions1 except it uses a tail-recursivelocal helper function. 
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  ~~ LOL! I'm already did it :D ~~ 
  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~*)
fun get_substitutions2(xss, str) = get_substitutions1(xss, str)

(* (d) Write a function similar_names, which takes a string list list of substitutions (as in parts (b) and(c)) and a full name 
of type {first:string,middle:string,last:string} and returns a list of fullnames (type {first:string,middle:string,last:string} list). 
The result is all the full names youcan produce by substituting for the first name (and only the first name) 
using substitutions and parts (b)or (c). The answer should begin with the original name (then have 0 or more other names). 
Example:similar_names([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],{first="Fred", middle="W", last="Smith"}) 
answer: [{first="Fred", last="Smith", middle="W"},
         {first="Fredrick", last="Smith", middle="W"},
         {first="Freddie", last="Smith", middle="W"},
         {first="F", last="Smith", middle="W"}] *)
fun similar_names(xss, {first=f, middle=m, last=l}) = 
    let 
      val other_firsts = f::get_substitutions1(xss, f)
    in
      let
      fun get_answer(sub_firsts, names) =
        case sub_firsts of
          [] => names
        | x::xs' => get_answer(xs', names@[{first = x, middle=m, last=l}])
      in
      get_answer(other_firsts, [])
    end
  end

(* =================================================================================== *)

(* you may assume that Num is always used with values 2, 3, ..., 10
   though it will not really come up *)
datatype suit = Clubs | Diamonds | Hearts | Spades
datatype rank = Jack | Queen | King | Ace | Num of int 
type card = suit * rank

datatype color = Red | Black
datatype move = Discard of card | Draw 

exception IllegalMove

(*
 * put your solutions for problem 2 here 
 *)

(* (a) Write a function card_color, which takes a card and returns its color (spades and clubs are black,diamonds and hearts 
are red). Note: One case-expression is enough. *)
fun card_color(card, _) = 
  case card of
    (Clubs | Spades) => Black
    | _ => Red

(* (b) Write a function card_value, which takes a card and returns its value (numbered cards have theirnumber as the value, 
aces are 11, everything else is 10). Note: One case-expression is enough. *)
fun card_value(_, card) =
  case card of
      Num x => x
    | Ace => 11
    | _   => 10

(* (c) Write a function remove_card, which takes a list of cards cs, a card c, and an exception e. 
It returns alist that has all the elements of cs except c. If c is in the list more than once, remove only the first one.
If c is not in the list, raise the exception e.  *)
fun remove_card(cs, c, e) =
  let
    fun remove(checked_cards, cs) =
      case cs of
        []    => checked_cards
      | x::xs' => if (x = c)
                 then checked_cards@xs'
                 else remove(x::checked_cards, xs')
  
    val new_list = remove([], cs)
  
    fun check_exp() = 
      if (new_list = cs)
      then raise e
      else new_list
    in
      check_exp()
  end

(* (d) Write a function all_same_color, which takes a list of cards and returns true
   if all the cards in thelist are the same color.  *)
fun all_same_color(cs) = 
  case cs of
      [] => true
    | x::[] => true
    | f::s::xs' => if card_color(f) = card_color(s)
                  then all_same_color(s::xs')
                  else false
                
(* (e) Write a function sum_cards, which takes a list of cards and returns the sum of their values.  *)
fun sum_cards(cs) = 
  let 
    fun sum(values, cards) = 
      case cards of
        [] => values
       | x::xs' => sum(card_value(x) + values, xs')
  in
    sum(0, cs)
  end

(* (f) Write a function score, which takes a card list (the held-cards) and an int (the goal) 
  and computesthe score as described. *)
fun score(cs, goal) = 
  let 
    val sum_val = sum_cards(cs)
    val is_sum_greater = sum_val > goal
    val is_same_color = all_same_color(cs)
  in
    case (is_sum_greater, is_same_color) of
        (true, false)  => 3 * (sum_val - goal)
     |  (true, true)   => 3 * (sum_val - goal) div 2
     |  (false, false) => goal - sum_val
     |  (false, true)  => (goal - sum_val) div 2
  end

(* (g) Write a function officiate, which “runs a game.” It takes a card list (the card-list) a move list(what the player “does” at each point),
    and an int (the goal) and returns the score at the end of thegame after processing (some or all of) the moves in the move list in order. *)
fun officiate(cs, ms, goal) =
  let
    fun run(cs, ms, hs) = 
      case ms of
        [] => score(hs, goal)
      | m::ms' => case m of
                      Discard d => run(cs, ms', remove_card(hs, d, IllegalMove))
                    | _         => case cs of
                                        []      => score(hs, goal)
                                      | c::cs'  => if sum_cards(hs) > goal
                                                   then score(c::hs, goal)
                                                   else run(cs', ms', c::hs)
  in
    run(cs, ms, [])
  end

(* =================================================================================== *)

(*
 * 3. Challenge Problems:
 *)

 (* (a) Write score_challenge and officiate_challenge  *)
 fun replace_one_ace(cs) =
  case cs of
      [] => []
    | (c, Ace)::xs' => (c,Num(1))::xs'
    | card::xs' => card::replace_one_ace(xs')

fun replace_one_ace_move(cs) =
  case cs of
      [] => []
    | Discard(c, Ace)::xs' => Discard(c,Num(1))::xs'
    | card::xs' => card::replace_one_ace_move(xs')					

fun least_of(ls) =
  case ls of
      [] => 0
    | x::[] => x
    | x::xs' => let val min = least_of(xs')
		in if min < x
		   then min
		   else x
		end;
				     
fun score_challenge(cs,g) =
  let fun container(cs) =
	  let val replaced = replace_one_ace(cs)
      in if cs = replaced
        then [score(cs,g)]
        else score(cs,g)::container(replaced)
      end
  in 
    least_of(container(cs))
  end;

fun officiate_challenge(cds,moves,i) =
  let fun container(cs, moves) =
    let val replaced = replace_one_ace(cs)
        val repl_moves = replace_one_ace_move(moves)
	in if cs = replaced
	   then [officiate(cs,moves,i)]
	   else officiate(cs,moves,i)::container(replaced, repl_moves)
	end
   in least_of(container(cds, moves))
  end;

(* (b) Write careful_player, which takes a card-list and a goal and returns a move-list *)
fun careful_player(cs,g) =
  let fun research_discard(held, new_card, total_value) =
	case held of
	    [] => NONE
	  | card::xs' => if total_value - card_value(card) + card_value(new_card) = g
			 then SOME([Discard(card),Draw])
			 else research_discard(xs', new_card, total_value)
	  
      fun helper(cs,held,moves) =
	case (cs, score(held,g) = 0) of
	    (_,true) => moves
	  | ([],false) => moves
	  | (card::xs',false) => if sum_cards(held) <= g - 11
				 then helper(xs',held@[card],moves@[Draw])
				 else case research_discard(held, card, sum_cards(held)) of
					  NONE => moves
					| SOME(move) => helper(xs',held@[card],moves@move)
  in 
    helper(cs,[],[])
  end;
  