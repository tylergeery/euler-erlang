-module(eight).
-export([largest_product/2]).

largest_product(S, N) ->
    case (length(S) > N) of
        true ->
            [_|T] = S,
            Seq = lists:sublist(S, 1, N),
            lists:max([
                multiply_digits(list_to_integer(Seq)),
                largest_product(T, N)
            ]);
        false -> multiply_digits(list_to_integer(S))
    end.

multiply_digits(N) ->
    multiply_digits(N, 1).
multiply_digits(_, 0) ->
    0;
multiply_digits(N, Acc) ->
    R = N rem 10,
    case N < 10 of
        true -> Acc * R;
        false ->
             multiply_digits(N div 10, Acc * R)
    end.
