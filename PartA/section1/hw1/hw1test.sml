(* Homework1 Simple Test *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw1.sml";

(* val test1_0 = is_older ((1,2,3),(2,3,4)) = true
val test1_1 = is_older ((1,2,3),(1,2,4)) = true
val test1_2 = is_older ((1,2,3),(1,3,3)) = true
val test1_3 = is_older ((1,2,3),(2,2,3)) = true
val test1_4 = is_older ((1,2,3),(1,2,3)) = false
val test1_5 = is_older ((11,11,3),(12,12,2)) = false

val breakLine0 = "--------------------------"

val test2_0 = number_in_month ([(2012,2,28),(2013,12,1)],2) = 1
val test2_1 = number_in_month ([(2012,2,28),(2013,12,1)],3) = 0
val test2_2 = number_in_month ([(2012,3,28),(2013,3,1)],3) = 2
val test2_3 = number_in_month ([(2012,2,28)],2) = 1
val test2_4 = number_in_month ([(2012,2,28)],5) = 0
val test2_5 = number_in_month ([],5) = 0

val breakLine1 = "--------------------------" 

val test3_0 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = 3
val test3_1 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3]) = 2
val test3_2 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,11]) = 2
val test3_3 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,12]) = 4
val test3_4 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[15,13,14]) = 0
val test3_5 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[12,13,14]) = 1
val test3_6 = number_in_months ([],[2,3,4]) = 0
val test3_7 = number_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = 0

val breakLine2 = "--------------------------" *)

val test4_0 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]
val test4_1 = dates_in_month ([(2012,2,28),(2013,2,1)],2) = [(2012,2,28),(2013,2,1)]
val test4_2 = dates_in_month ([],2) = []
val test4_3 = dates_in_month ([(2012,2,28),(2013,12,1)],0) = []
val test4_4 = dates_in_month ([(2013,12,1),(2012,2,28)],2) = [(2012,2,28)]
val test4_5 = dates_in_month ([(2013,11,1),(2012,2,28),(2013,11,28),(2011,11,12)],11) = [(2011,11,12),(2013,11,1),(2013,11,28)]
val test4_6 = dates_in_month ([(2013,2,1),(2012,2,28)],2) = [(2012,2,28),(2013,2,1)]


val breakLine3 = "--------------------------"

(*
val test5 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]

val test6 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"

val test7 = date_to_string (2013, 6, 1) = "June 1, 2013"

val test8 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3

val test9 = what_month 70 = 3

val test10 = month_range (31, 34) = [1,2,2,2]

val test11 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31) *)