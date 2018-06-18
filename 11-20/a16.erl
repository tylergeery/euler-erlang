-module(a16).
-export([sum_exp_digits/2]).

sum_exp_digits(Base, Pow) ->
    digit_sum(list_build([1], Base, Pow), 0).

get_next([], 0, _, NextList) ->
    lists:reverse(NextList);
get_next([], Carry, _, NextList) ->
    lists:reverse(NextList ++ [0 + Carry]);
get_next([H|T], Carry, Base, NextList) ->
    Next = H * Base + Carry,
    get_next(T, trunc(Next/10), Base, NextList ++ [Next rem 10]).

list_build(List, _, 0) ->
    List;
list_build(List, Base, Rem) ->
    list_build(get_next(lists:reverse(List), 0, Base, []), Base, Rem-1).

digit_sum([], Sum) -> Sum;
digit_sum([H|T], Sum) -> digit_sum(T, H + Sum).
