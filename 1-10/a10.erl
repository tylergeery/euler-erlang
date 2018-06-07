-module(a10).
-export([primeSum/1]).

primeSum(N) when N > 2 ->
    2 + primeSum(N, 3, 0).
primeSum(N, Iter, Sum) when Iter < N ->
    case three:is_prime(Iter) of
        true -> primeSum(N, Iter + 2, Sum + Iter);
        false -> primeSum(N, Iter + 2, Sum)
    end;
primeSum(_  , _, Sum) -> Sum.
