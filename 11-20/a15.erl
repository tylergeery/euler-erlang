-module(a15).
-export([grid_path_count/1]).

factorial(0) -> 1;
factorial(N) when N > 0 -> N * factorial(N-1).

grid_path_count(N) when N > 0 ->
    Unique = factorial(N),
    trunc(factorial(2*N) / (Unique * Unique)).
