-module(seven).
-export([nth_prime/1]).

nth_prime(N) ->
    nth_prime(1, 1, N).
nth_prime(Iter, Current, Limit) when Limit >= Current ->
    case three:is_prime(Iter) of
        true ->
            case Current == Limit of
                true -> Iter;
                false -> nth_prime(Iter + 1, Current + 1, Limit)
            end;
        false ->
            nth_prime(Iter + 1, Current, Limit)
    end.
