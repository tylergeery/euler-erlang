-module(a20).
-export([sum_digits_factorial/1]).

sum_digits_factorial(N) when N > 0 ->
    sum_digits(integer_to_list(fac(N, 1)), 0).

fac(0, Curr) -> Curr;
fac(N, Curr) -> fac(N-1, Curr * N).

sum_digits([], Curr) -> Curr;
sum_digits([H|T], Curr) ->
    sum_digits(T, Curr + (H - 48)).
