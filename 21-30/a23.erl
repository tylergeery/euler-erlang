-module(a23).
-export([get_abundant/0, divisors/1]).

is_abundant(N) ->
    lists:sum(divisors(N)) > N.

filter_abundant(Tuples) -> filter_abundant(Tuples, []).
filter_abundant([], Abundant) -> lists:sort(Abundant);
filter_abundant([{_, false}|T], Abundant) -> filter_abundant(T, Abundant);
filter_abundant([{N, true}|T], Abundant) -> filter_abundant(T, [N] ++ Abundant).

is_sum_abundant(N, Sum_Abundant) ->
    length(
        lists:filter(
            fun(Val) -> Val == N end,
            Sum_Abundant
        )
    ) > 1.

get_abundant() ->
    Tuples = [{X, is_abundant(X)} || X <- lists:seq(1, 28123)],
    Abundant = filter_abundant(Tuples),
    Sum_Abundant = lists:sort([X+Y || X <- Abundant,
            Y <- Abundant,
            X >= Y]),
    lists:filter(
        fun(Val) -> is_sum_abundant(Val, Sum_Abundant) end,
        [X || X <- lists:seq(1, 28123)]
    ).


divisors(Value) -> divisors(Value, trunc(math:sqrt(Value)), []).
divisors(1, _, _) -> [1];
divisors(_, 1, Divisors) -> lists:sort([1] ++ Divisors);
divisors(Value, Iter, Divisors) ->
    case Value rem Iter == 0 of
        true ->
            case (Iter * Iter) == Value of
                true -> divisors(Value, Iter-1, [Iter] ++ Divisors);
                false -> divisors(Value, Iter-1, [Iter, trunc(Value/Iter)] ++ Divisors)
            end;
        false -> divisors(Value, Iter-1, Divisors)
    end.
