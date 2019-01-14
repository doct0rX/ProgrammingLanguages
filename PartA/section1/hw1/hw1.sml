(* Homework1 answer
 * Author: Mustafa Jamal *)

(* 1. Function is_older that takes two dates and evaluates to true or false. It evaluates to true if
the first argument is a date that comes before the second argument. (If the two dates are the same,
the result is false.) *)
fun is_older((a:int, b:int, c:int), (x:int, y:int, z:int)) =
    if (z > c)
    then true
    else if (z = c andalso y > b)
        then true
        else if (y = b andalso x > a)
            then true
            else false

(* 2. Function number_in_month that takes a list of dates and a month (i.e., an int) and returns
how many dates in the list are in the given month. *)
fun number_in_month(date: (int*int*int) list, month: int) =
    if null date
    then 0
    else 
        if #2 (hd date) = month
        then 1 + number_in_month(tl(date), month)
        else number_in_month(tl(date), month)

(* 3. Function number_in_months that takes a list of dates and a list of months (i.e., an int list)
and returns the number of dates in the list of dates that are in any of the months in the list of months.
Assume the list of months has no number repeated. *)
fun number_in_months(date: (int*int*int) list, months: int list) = 
    if null months
    then 0
    else number_in_month(date, hd(months)) + number_in_months(date, tl(months))

 (* 4. Function dates_in_month that takes a list of dates and a month (i.e., an int) and returns a
list holding the dates from the argument list of dates that are in the month. The returned list should
contain dates in the order they were originally given. *)
fun dates_in_month(date: (int*int*int) list, month: int) =
        if null date
        then []
        else
            if #2 (hd date) = month
            then hd date::dates_in_month(tl date, month)
            else dates_in_month(tl date, month)

(* 5. Function dates_in_months that takes a list of dates and a list of months (i.e., an int list)
and returns a list holding the dates from the argument list of dates that are in any of the months in
the list of months. Assume the list of months has no number repeated. *)
fun dates_in_months(date: (int*int*int) list, months: int list) = 
    if null months
    then []
    else dates_in_month(date, hd(months))@dates_in_months(date, tl(months))

(* 6. Function get_nth that takes a list of strings and an int n and returns the nth element of the list 
where the head of the list is 1st. *)
fun get_nth(strings: string list, n: int) =
    let
        fun get_nth_inner(strings: string list, n: int, x: int) = 
            if null strings
            then ""
            else
                if n = 0
                then ""
                else 
                    if n <> x
                    then get_nth_inner(tl(strings), n-1, x)
                    else hd(strings)
     in
      get_nth_inner(strings, n, 1)
    end
    
(* 7. Function date_to_string that takes a date and returns a string of the form January 20, 2013
(for example). Use the operator ^ for concatenating strings and the library function Int.toString
for converting an int to a string. For producing the month part, do not use a bunch of conditionals.
Instead, use a list holding 12 strings and your answer to the previous problem. For consistency, put a
comma following the day and use capitalized English month names: January, February, March, April,
May, June, July, August, September, October, November, December. *)
fun date_to_string (yr: int, month:int, day: int) =
    let
        val months = ["January", "February", "March", "April","May", "June", "July",
                     "August", "September", "October", "November", "December"]
    in
        get_nth(months, month) ^ " " ^ Int.toString(day) ^ ", " ^ Int.toString(yr)
    end

(* 8. Function number_before_reaching_sum that takes an int called sum, which you can assume
is positive, and an int list, which you can assume contains all positive numbers, and returns an int.
You should return an int n such that the first n elements of the list add to less than sum, but the first
n + 1 elements of the list add to sum or more. *)
fun number_before_reaching_sum(sum: int, sums: int list) =
    let
        fun  number_before_reaching_sum_inner(sums: int list, totalSums: int, beforeReaching: int) =
        if null sums
        then 0
        else
            if sum = 0
            then 0
            else
                if (totalSums = sum orelse totalSums > sum)
                then beforeReaching
                else number_before_reaching_sum_inner(tl(sums), totalSums+hd(tl(sums)), hd(sums))
    in
        number_before_reaching_sum_inner(sums, hd(sums), hd(sums))
    end

 (* 9. Function what_month that takes a day of year (i.e., an int between 1 and 365) and returns
what month that day is in (1 for January, 2 for February, etc.). *)
fun what_month(dayOfAYear: int) = 
    let
        val monthsOfAYaar   =   [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        val monthsOfALeapYear = [31, 29, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
        fun  what_month_inner(totalDays: int, month: int) =
            if (totalDays > dayOfAYear orelse totalDays = dayOfAYear)
            then month
            else what_month_inner(totalDays+hd(monthsOfAYaar), month+1)
    in
       what_month_inner(0, 0)
    end

(* 10. Function month_range that takes two days of the year day1 and day2 and returns an int list
[m1,m2,...,mn] where m1 is the month of day1, m2 is the month of day1+1, ..., and mn is the month
of day day2. *)
fun month_range(day1: int, day2: int) = 
    if day2 < day1
    then []
    else what_month(day1)::month_range(day1+1, day2)

(* 11. Function oldest that takes a list of dates and evaluates to an (int*int*int) option. It
evaluates to NONE if the list has no dates and SOME d if the date d is the oldest date in the list. *)
fun oldest(dates: (int*int*int) list) = 
    if null dates
    then NONE
    else
        let
            val previousDate = hd(dates)
        in
            if null (tl(dates))
            then SOME (hd dates)
            else
                if (is_older(hd(dates), (hd(tl(dates)))) = true andalso null (tl(tl(dates))))
                then SOME (hd dates)
                else
                    if (is_older(hd(dates), (hd(tl(dates)))) = false andalso null (tl(tl(dates))))
                    then SOME (hd(tl(dates)))
                    else NONE
        end
    