-module(three).

-export([largest_prime_factor/1, is_prime/1]).

get_factor(F, N) when N > F ->
    case trunc(N) rem F of
        0 ->
            lists:filter(fun(Y) -> is_prime(Y) end, [F, N / F]);
        _Else ->
            []
    end;
get_factor(_, _) ->
    [].

is_prime(N) when N < 4 ->
    true;
is_prime(N) ->
    N1 = trunc(N),
    if
        (N1 rem 2) == 0 -> false;
        (N1 rem 3) == 0 -> false;
        true -> largest_prime_factor(N) =:= 1
    end.

largest_prime_factor(N) when N > 0 ->
    largest_prime_factor(N, 2, trunc(math:sqrt(N))).
largest_prime_factor(N, C, L) ->
    if
        L >= C ->
            lists:max(get_factor(C, N) ++ [largest_prime_factor(N, C + 1, L)]);
        true -> 1
    end.
