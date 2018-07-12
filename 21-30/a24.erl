-module(a24).
-export([lexo/1, nth_lexo/2]).

set(L, Pos, Val) ->
    lists:sublist(L, Pos-1) ++ [Val] ++ lists:sublist(L, Pos+1, length(L)).

swap(L, Val) ->
    {Next, I1, I2} = next(L, Val, Val+1),
    io:format("Swapping L: ~p, Val: ~p, Next: ~p, I1: ~p, I2: ~p~n", [L, Val, Next, I1, I2]),
    {H,T} = lists:split(I1, set(set(L, I1, Next), I2, Val)),
    H ++ lists:sort(T).

next(L, Val, Next) ->
    I1 = index_of(Val, L),
    I2 = index_of(Next, L),
    case I1 > I2 of
        true -> next(L, Val, Next+1);
        false -> {Next, I1, I2}
    end.

index_of(Val, L) -> index_of(Val, L, 1).
index_of(Val, [Val|_], Index) -> Index;
index_of(Val, [_|T], Index) -> index_of(Val, T, Index+1).

next_option(L) ->
    next_option(L, length(L) - 1).
next_option(L, Indy) ->
    {_,T} = lists:split(Indy, L),
    case T == lists:reverse(lists:sort(T)) of
        true -> next_option(L, Indy-1);
        false -> swap(L, lists:nth(Indy+1, L))
    end.

lexo(L) when length(L) > 1 ->
    lexo(L, lists:sort(L), []).
lexo(L, Sorted, Possible) ->
    Rev = lists:reverse(Sorted),
    case L == Rev of
        true -> lists:reverse([L] ++ Possible);
        false -> lexo(next_option(L), Sorted, [L] ++ Possible)
    end.

nth_lexo(L, N) ->
    lists:nth(N, lexo(L)).
