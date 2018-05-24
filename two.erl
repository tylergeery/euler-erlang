-module(two).
-export([sumFibUnderMax/1]).

fib(N) when N < 2 ->
    1;
fib(N) ->
    fib(N-1) + fib(N-2).

findNthFib(Max) ->
    findNthFib(Max, 1).
findNthFib(Max, N) ->
    NthFib = fib(N),
    if NthFib > Max ->
        N - 1;
    true ->
        findNthFib(Max, N + 1)
    end.

sumEvenFib(N) ->
    S = fib(N),
    if
        S == 1 ->
            0;
        S rem 2 == 0 ->
            S + sumEvenFib(N-1);
        true ->
            sumEvenFib(N-1)
    end.

sumFibUnderMax(Max) when Max > 1 ->
    N = findNthFib(Max),
    sumEvenFib(N).
