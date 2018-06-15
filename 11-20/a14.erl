-module(a14).
-export([longest_collatz/1]).

longest_collatz(N) when N > 1 ->
    All = [{X, length(collatz(X, []))} || X <- lists:seq(1, N)],
    max_collatz(All, {1, 1}).

collatz(1, List) ->
    List ++ [1];
collatz(Curr, List) ->
    case Curr rem 2 of
        0 -> collatz(trunc(Curr/2), List ++ [Curr]);
        1 -> collatz(3*Curr+1, List ++ [Curr])
    end.

max_collatz([], Max) -> Max;
max_collatz([Curr|List], {N, Max}) ->
    {M, MCount} = Curr,
    case MCount > Max of
        true -> max_collatz(List, {M, MCount});
        false -> max_collatz(List, {N, Max})
    end.
