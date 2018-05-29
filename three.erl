-module(three).

-export([largest_prime_factor/1]).

get_factor(F, N) when N > F ->
    case trunc(N) rem F of
        0 ->
            lists:filter(fun(Y) -> is_prime(Y) end, [F, N / F]);
        _Else ->
            []
    end;
get_factor(_, _) ->
    [].

is_prime(1) ->
    true;
is_prime(N) ->
    case largest_prime_factor(N) of
        1 -> true;
        _Else -> false
    end.

largest_prime_factor(N) when N > 0 ->
    largest_prime_factor(N, 2, trunc(math:sqrt(N))).
largest_prime_factor(N, C, L) ->
    if
        L >= C ->
            lists:max(get_factor(C, N) ++ [largest_prime_factor(N, C + 1, L)]);
        true -> 1
    end.
