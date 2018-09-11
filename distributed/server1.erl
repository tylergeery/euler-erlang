-module(server1).
-export([fib_dist/2]).

fib(N) when N < 2 ->
    1;
fib(N) ->
    fib(N-1) + fib(N-2).

fib_dist(N, Pid) ->
    Pid ! {fib_result, N, fib(N)}.
