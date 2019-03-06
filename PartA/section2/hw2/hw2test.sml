(* Homework2 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw2.sml";

val test1__0 = all_except_option ("string", ["string"]) = SOME []
val test1__1 = all_except_option ("string", []) = NONE
val test1__2 = all_except_option ("string", ["strin"]) = NONE
val test1__3 = all_except_option ("string", ["strin", "strin99"]) = NONE
val test1__4 = all_except_option ("string", ["strin", "strin99", "string"]) = SOME ["strin","strin99"]

val test2__0 = get_substitutions1([["foo"],["there"]], "foo") = []
val test2__1 = get_substitutions1([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]],"Fred") = ["Fredrick","Freddie","F"]
val test2__2 = get_substitutions1([["Fred","Fredrick"],["Jeff","Jeffrey"],["Geoff","Jeff","Jeffrey"]],"Jeff") = ["Jeffrey","Geoff","Jeffrey"]

val test3___ = get_substitutions2 ([["foo"],["there"]], "foo") = []

val test4___ = similar_names ([["Fred","Fredrick"],["Elizabeth","Betty"],["Freddie","Fred","F"]], {first="Fred", middle="W", last="Smith"}) =
	    [{first="Fred", last="Smith", middle="W"}, {first="Fredrick", last="Smith", middle="W"},
	     {first="Freddie", last="Smith", middle="W"}, {first="F", last="Smith", middle="W"}]
 
val test5___ = card_color (Clubs, Num 2) = Black

val test6___ = card_value (Clubs, Num 2) = 2

val test7__0 = remove_card ([(Hearts, Ace)], (Hearts, Ace), IllegalMove) = []
val test7__1 = remove_card ([(Hearts, Ace), (Hearts, Ace), (Hearts, Ace)], (Hearts, Ace), IllegalMove) = [(Hearts, Ace), (Hearts, Ace)]
val test7__2 = ((remove_card ([(Hearts, Ace)], (Hearts, King), IllegalMove); false) handle IllegalMove => true)

val test8___ = all_same_color [(Hearts, Ace), (Hearts, Ace)] = true

val test9__0 = sum_cards [(Clubs, Num 2),(Clubs, Num 2)] = 4
val test9__1 = sum_cards [(Clubs, Num ~1),(Clubs, Num 10), (Clubs, Num 0)] = 9

val test10_0 = score ([(Hearts, Num 2),(Clubs, Num 4)],10) = 4
val test10_1 = score ([(Spades, Num 2),(Clubs, Num 4)],10) = 2
val test10_2 = score ([(Hearts, Num 6),(Clubs, Num 5)],10) = 3
val test10_3 = score ([(Spades, Num 6),(Clubs, Num 5)],10) = 1

val test11_0 = officiate ([(Hearts, Num 2),(Clubs, Num 4)],[Draw], 15) = 6

val test11_1 = officiate ([(Clubs,Ace),(Spades,Ace),(Clubs,Ace),(Spades,Ace)],
                        [Draw,Draw,Draw,Draw,Draw],
                        42)
             = 3
val test11_2 = ((officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Hearts,Jack)],
                         42);
               false) 
              handle IllegalMove => true)


val test11_3 = officiate([(Clubs,Jack),(Spades,Num(8))],
                         [Draw,Discard(Clubs,Jack)],
                         42)
             = 21
