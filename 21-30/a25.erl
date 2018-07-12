-module(a25).
-export([fib_n_digits/1, fib/1]).

fib(1) -> 1;
fib(2) -> 1;
fib(A) when A > 2 -> fib(1,1,2,A).

fib(_, B, Limit, Limit) -> B;
fib(A, B, I, Limit) -> fib(B, A+B, I+1, Limit).

fib_n_digits(N) when N > 0 ->
    fib_n_digits(1, N).
fib_n_digits(F, N) ->
    Val = fib(F),
    case length(integer_to_list(Val)) >= N of
        true -> {F, Val};
        false -> fib_n_digits(F+1, N)
    end.
