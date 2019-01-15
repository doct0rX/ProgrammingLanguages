(* Homework1 Simple Test *)
(* Author: Mustafa Jamal *)
(* These are basic test cases. Passing these tests does not guarantee that your code will pass the actual homework grader *)
(* To run the test, add a new line to the top of this file: use "homeworkname.sml"; *)
(* All the tests should evaluate to true. For example, the REPL should say: val test1 = true : bool *)

use "hw1.sml";

val test1_0 = is_older ((1,2,3),(2,3,4)) = true
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
val breakLine2 = "--------------------------" 

val test4_0 = dates_in_month ([(2012,2,28),(2013,12,1)],2) = [(2012,2,28)]
val test4_1 = dates_in_month ([(2012,2,28),(2013,2,1)],2) = [(2012,2,28),(2013,2,1)]
val test4_2 = dates_in_month ([],2) = []
val test4_3 = dates_in_month ([(2012,2,28),(2013,12,1)],0) = []
val test4_4 = dates_in_month ([(2013,12,1),(2012,2,28)],2) = [(2012,2,28)]
val test4_5 = dates_in_month ([(2013,11,1),(2012,2,28),(2013,11,28),(2011,11,12)],11) = [(2013,11,1),(2013,11,28),(2011,11,12)]
val breakLine3 = "--------------------------"

val test5_0 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4]) = [(2012,2,28),(2011,3,31),(2011,4,28)]
val test5_1 = dates_in_months ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = []
val breakLine4 = "--------------------------"

val test6_0 = get_nth (["hi", "there", "how", "are", "you"], 2) = "there"
val test6_1 = get_nth (["hi", "there", "how", "are", "you"], 5) = "you"
val test6_2 = get_nth (["hi", "there", "how", "are", "you"], 0) = ""
val test6_3 = get_nth ([], 2) = ""
val breakLine5 = "--------------------------"


val test7 = date_to_string (2013, 6, 1) = "June 1, 2013"
val breakLine6 = "--------------------------"


val test8_0 = number_before_reaching_sum (10, [1,2,3,4,5]) = 3
val test8_1 = number_before_reaching_sum (0, [1,2,3,4,5]) = 0
val test8_2 = number_before_reaching_sum (2, [1,2,3,4,5]) = 1
(* val test8_3 = number_before_reaching_sum (10, []) = 0 *)
(* val test8_4 = number_before_reaching_sum (16, [1,2,3,4,5]) = 5 *)
val breakLine7 = "--------------------------"


val test9_0 = what_month 70 = 3
val test9_1 = what_month 0 = 0
val test9_2 = what_month 1 = 1
val test9_3 = what_month 365 = 12
val breakLine8 = "--------------------------"

val test10_0 = month_range (31, 34) = [1,2,2,2]
val breakLine9 = "--------------------------"

val test11_0 = oldest([(2012,2,28),(2011,3,31),(2011,4,28)]) = SOME (2011,3,31)
val test11_1 = oldest([]) = NONE
val test11_2 = oldest([(2012,2,28),(2011,4,28),(2011,3,31)]) = SOME (2011,3,31)
val test11_3 = oldest([(2011,4,28),(2012,2,28),(2011,3,31)]) = SOME (2011,3,31)
val test11_4 = oldest([(1,1,1),(1,1,1),(1,1,1)]) = NONE
val breakLine10 = "--------------------------"

val test12_0 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,3]) = 3
val test12_1 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3]) = 2
val test12_2 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,11]) = 2
val test12_3 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[2,3,4,3]) = 4
val test12_4 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[15,13,13]) = 0
val test12_5 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[12,13,14]) = 1
val test12_6 = number_in_months_challenge ([],[2,3,4]) = 0
val test12_7 = number_in_months_challenge ([(2012,2,28),(2013,12,1),(2011,3,31),(2011,4,28)],[]) = 0
val breakLine11 = "--------------------------" 

val test13_0 = reasonable_date (2012,2,28)  = true
val test13_1 = reasonable_date (~2011,4,28) = false
val test13_2 = reasonable_date (2011,1,33)  = false
val test13_3 = reasonable_date (2011,2,30)  = false
val test13_4 = reasonable_date (2011,2,29)  = true
val test13_5 = reasonable_date (2011,2,28)  = true
val test13_6 = reasonable_date (2011,12,11) = true
val test13_7 = reasonable_date (2011,13,11) = false
val test13_8 = reasonable_date (2011,0,11)  = false
val breakLine12 = "--------------------------" 
