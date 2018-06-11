-module(a11).
-compile(export_all).

max_prod_adj(Str) ->
    Tokens = lists:map(fun(T) -> list_to_integer(T) end, string:tokens(Str, " ")),
    register(waiter_pid, spawn(a11, track, [0, 0])),
    Row_length = trunc(math:sqrt(length(Tokens))),
    spawn(a11, up_left, [Tokens, Row_length]),
    spawn(a11, up, [Tokens, Row_length]),
    spawn(a11, up_right, [Tokens, Row_length]),
    spawn(a11, right, [Tokens, Row_length]),
    spawn(a11, down_right, [Tokens, Row_length]),
    spawn(a11, down, [Tokens, Row_length]).

max_prod_adj_sync(Str) ->
    Tokens = lists:map(fun(T) -> list_to_integer(T) end, string:tokens(Str, " ")),
    register(waiter_pid, spawn(a11, track, [0, 0])),
    Row_length = trunc(math:sqrt(length(Tokens))),
    up_left(Tokens, Row_length),
    up(Tokens, Row_length),
    up_right(Tokens, Row_length),
    right(Tokens, Row_length),
    down_right(Tokens, Row_length),
    down(Tokens, Row_length).


track(6, Max) ->
    io:format("Finished max: ~p~n", [Max]);
track(Count, Max) ->
    receive
        {A, N} ->
            io:format("Received max from ~p: ~p~n", [A, N]),
            track(Count+1, lists:max([Max, N]))
    end.

calculate(N, Pos, Tokens) ->
    lists:nth(Pos, Tokens) * lists:nth(Pos+N, Tokens) * lists:nth(2*N+Pos, Tokens) * lists:nth(3*N+Pos, Tokens).
up_left(Tokens, Row_length) ->
    L = [calculate(-1*(Row_length+1), X, Tokens) ||
        X <- lists:seq(Row_length*3+1, length(Tokens)),
        X > 3 * Row_length,
        X rem Row_length > 3],
    waiter_pid ! {up_left, lists:max(L)}.
up(Tokens, Row_length) ->
    L = [calculate(-1*Row_length, X, Tokens) ||
        X <- lists:seq(Row_length*3+1, length(Tokens)),
        X > 3 * Row_length],
    waiter_pid ! {up, lists:max(L)}.
up_right(Tokens, Row_length) ->
    L = [calculate(-1*(Row_length-1), X, Tokens) ||
        X <- lists:seq(Row_length*3+1, length(Tokens)),
        X > 3 * Row_length,
        X rem Row_length < 18],
    waiter_pid ! {up_right, lists:max(L)}.
right(Tokens, Row_length) ->
    L = [calculate(1, X, Tokens) ||
        X <- lists:seq(1, length(Tokens)),
        X rem Row_length < 18],
    waiter_pid ! {right, lists:max(L)}.
down_right(Tokens, Row_length) ->
    L = [calculate(Row_length+1, X, Tokens) ||
        X <- lists:seq(1, length(Tokens)),
        X =< (Row_length-3) * Row_length,
        X rem Row_length < 18],
    waiter_pid ! {down_right, lists:max(L)}.
down(Tokens, Row_length) ->
    L = [calculate(Row_length, X, Tokens) ||
        X <- lists:seq(1, length(Tokens)),
        X =< (Row_length-3) * Row_length],
    waiter_pid ! {down, lists:max(L)}.
