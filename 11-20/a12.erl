-module(a12).
-export([triangle_n_divisors/1, funT/1]).

triangle_n_divisors(Limit) ->
    triangle_n_divisors(Limit, next_triangle({12059, 72715770})).
triangle_n_divisors(Limit, {N, Value}) ->
    Count = divisor_count(Value, trunc(math:sqrt(Value)), 0),
    io:format("Limit: ~p, Triangle: {~p, ~p}, Count: ~p~n", [Limit, N, Value, Count]),
    case Count > Limit of
        true -> {N, Value};
        false -> triangle_n_divisors(Limit, next_triangle({N, Value}))
    end.

funT(N) when N > 0 ->
    funT(N-1, next_triangle({0, 0})).
funT(0, {N, Value}) ->
    {N, Value};
funT(Iter, {N, Value}) ->
    funT(Iter-1, next_triangle({N, Value})).


next_triangle({N, Value}) ->
    io:format("N: ~p, Value: ~p~n", [N, Value]),
    {N+1, Value+N+1}.

divisor_count(1, _, _) ->
    1;
divisor_count(_, 1, Count) ->
    Count + 2;
divisor_count(Value, Iter, Count) ->
    case Value rem Iter == 0 of
        true ->
            case (Iter * Iter) == Value of
                true -> divisor_count(Value, Iter-1, Count+1);
                false -> divisor_count(Value, Iter-1, Count+2)
            end;
        false -> divisor_count(Value, Iter-1, Count)
    end.
