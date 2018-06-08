-module(a11).
-export([max_prod_adj/1]).

max_prod_adj(Str) ->
    Tokens = list:map(fun(T) -> list_to_integer(T) end, string:tokens(Str, " ")),
    register(waiter, spawn(a11, track, [0, 0])),
    register(worker, spawn(a11, work, [Tokens])).

track(8, Max) ->
    worker ! Max;
track(Count, Max) ->
    receive
        {max, N} ->
            io:format("Received max: ~p~n", [N]),
            track(Count+1, lists:max([Max, N]))
    end.


work(Tokens) ->
    Row_length = trunc(math:sqrt(length(Tokens))),
    spawn(a11, up_left, [Tokens, Row_length]).

calculate(N, Pos, Tokens) ->
    Tokens[Pos] * Tokens[Pos + N] * Tokens[2*N+Pos] * Tokens[3*N+Pos].
up_left(Tokens, Pos, Row_length) ->
    Pos1 = X - Row_length - 1,
    Pos2 = X - 2*Row_length - 2,
    Pos3 = X - 3*Row_length - 3,
    L = [calculate(X, -1*(Row_length+1), Tokens) ||
        X <- lists:seq(Row_length*3, length(Tokens) -1),
        X > 3 * Row_length,
        X rem Row_length > 2],
    waiter ! {max, lists:max(L)}.
