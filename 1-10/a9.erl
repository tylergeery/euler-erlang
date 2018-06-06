-module(a9).
-export([product_py_triplet/1]).

product_py_triplet(N) when N > 0 ->
    {A, B, C} = py_triplet(N, 1, 2, N-3),
    A * B * C.

validate(N, A, B, C) ->
    P = A + B + C,
    case P == N of
        true -> (A*A + B*B) == (C*C);
        false -> false
    end.


next(N, A, B, C) ->
    if
        A > trunc(N/3) -> {0, 0, 0};
        B >= C -> py_triplet(N, A+1, A+2, N-(2*A)-3);
        true -> py_triplet(N, A, B+1, N-A-B-1)
    end.

py_triplet(N, A, B, C) ->
    case validate(N, A, B, C) of
        true -> {A, B, C};
        false -> next(N, A, B, C)
    end.
