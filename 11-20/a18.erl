-module(a18).
-export([triangle_sum/1]).

triangle_sum(Tri_Str) ->
    Tri = [string:tokens(X, " ") || X <- string:tokens(Tri_Str, "\n")],
    solve(Tri).

solve(Tri) ->
    lists:max([bottom_up(Tri, 0, X) || X <- lists:seq(1, length(Tri))]).

bottom_up([H|[]], Sum, _) ->
    [Val] = H,
    list_to_integer(Val) + Sum;
bottom_up(Tri, Sum, Index) ->
    L = length(Tri),
    [Bottom | Tri_Rev] = lists:reverse(Tri),
    Rem = lists:reverse(Tri_Rev),
    case Index of
        1 ->
            [H | _] = Bottom,
            bottom_up(Rem, Sum + list_to_integer(H), 1);
        L ->
            bottom_up(Rem, Sum + list_to_integer(lists:last(Bottom)), L-1);
        _Else->
            lists:max(
                [
                    bottom_up(Rem, Sum + list_to_integer(lists:nth(Index, Bottom)), Index),
                    bottom_up(Rem, Sum + list_to_integer(lists:nth(Index, Bottom)), Index-1)
                ]
            )
    end.
