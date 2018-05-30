-module(seven).
-export([nth_prime/1]).

nth_prime(N) ->
    case code:load_file(three) of
        {error, _} ->
            code:purge(three),
            nth_prime(N);
        {module, three} -> nth_prime(1, 1, N)
    end.
nth_prime(Iter, Current, Limit) when Current < Limit ->
    case three:is_prime(Iter) of
        true ->
            case Current == Limit of
                true -> Iter;
                false -> nth_prime(Iter + 1, Current + 1, Limit)
            end;
        false ->
            nth_prime(Iter + 1, Current, Limit)
    end.
