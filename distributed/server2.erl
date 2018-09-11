-module(server2).
-export([wait_for_fib_of_duration/1]).

wait_for_fib_of_duration(Time) ->
    wait_for_fib_of_duration(Time, 1).
wait_for_fib_of_duration(Time, N) ->
    rpc:async_call('server1@server1', server1, fib_dist, [N, self()]),
    receive
        {fib_result, M, Val} ->
            io:format("fib(~p) = ~p~n", [M, Val]),
            wait_for_fib_of_duration(Time, N+1)
    after (Time * 1000) ->
        io:format("Next fib(~p) took longer than ~p secs~n", [N, Time])
    end.
