-module(six).
-export([diff_sum_n_square/1]).

sum(N) ->
    case N < 2 of
        true -> N;
        false -> N + sum(N-1)
    end.

sum_squares(N) ->
    case N < 2 of
        true -> N * N;
        false -> (N * N) + sum_squares(N-1)
    end.

diff_sum_n_square(N) ->
    SumN = sum(N),
    SumN * SumN - sum_squares(N).
