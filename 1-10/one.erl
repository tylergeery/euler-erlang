-module(one).
-export([sumMultiples/1]).

sumMultiples(0) ->
	0;
sumMultiples(N) ->
	if
		N rem 3 == 0; N rem 5 == 0 ->
			N + sumMultiples(N-1);
		true ->
			sumMultiples(N-1)
	end.
