(* Homework1 answer*)

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
fun number_in_months(date: (int*int*int) list, month: int list) = 
    if null month
    then 0
    else number_in_month(date, hd(month)) + number_in_months(date, tl(month))

 (* 4. Function dates_in_month that takes a list of dates and a month (i.e., an int) and returns a
list holding the dates from the argument list of dates that are in the month. The returned list should
contain dates in the order they were originally given. *)
fun dates_in_month(date: (int*int*int) list, month: int) =
    let
       val outDates = dates_in_month(tl date, month)
    in
        if null date
        then []
        else 
            if #2 (hd date) = month
            then hd date::outDates
            else outDates
    end
    
    