-module(five).
-export([div_by_first/1]).

is_divisible_by(Iter, Divisor) when Divisor > 0 ->
    case Iter rem Divisor of
        0 -> case Divisor of
            1 -> true;
            _Else -> is_divisible_by(Iter, Divisor - 1)
        end;
        _Else -> false
    end.

div_by_first(N) when N > 0 ->
    div_by_first(N, N+1).
div_by_first(N, Iter) ->
    case is_divisible_by(Iter, N) of
        true -> Iter;
        false -> div_by_first(N, Iter+1)
    end.
