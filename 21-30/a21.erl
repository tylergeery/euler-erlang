-module(a21).
-export([sum_all_amicable/1, sum_div/1]).

sum_all_amicable(N) when N > 0 ->
    Pairs = [{X, Y} || X <- lists:seq(1, N),
                                 Y <- lists:seq(1, N),
                                 X < Y],
    sum_pairs(Pairs, 0).

sum_pairs([], Total) -> Total;
sum_pairs([H|T], Total) ->
    {X, Y} = H,
    Sum_X = sum_div(X),
    Sum_Y = sum_div(Y),
    if
        Sum_X == Y, X == Sum_Y ->
            io:format("X: ~p, Y: ~p~n", [X, Y]),
            sum_pairs(T, Total + X + Y);
        true -> sum_pairs(T, Total)
    end.

sum_div(N)->
    lists:sum(find_div(N)) + 1.

find_div(N) ->
    find_div(N, 2, trunc(math:sqrt(N))+1, []).
find_div(Base, Curr, Lim, Ami) when Curr < Lim ->
    Div = trunc(Base/Curr),
    Allow = (Base rem Curr == 0) and (Div > Curr),
    case Allow of
        true -> find_div(Base, Curr+1, Lim, Ami ++ [Curr, Div]);
        false -> find_div(Base, Curr+1, Lim, Ami)
    end;
find_div(_, _, _, Ami) -> Ami.
