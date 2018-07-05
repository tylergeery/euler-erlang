-module(a22).
-export([name_count/2, solve/0]).

solve() ->
    case file:read_file("./p022_names.txt") of
        {ok, Binary} ->
            Names = collect_names(binary:split(Binary, [<<",">>], [global]), []),
            count_names(Names);
        {error, Reason} -> Reason
    end.

collect_names([], Accum) ->
    lists:sort(Accum);
collect_names([H|T], Accum) ->
    collect_names(T, [clean_name(H)] ++ Accum).

clean_name(Name) ->
    string:strip(binary_to_list(Name), both, $").

count_names(List) ->
    count_names(List, 1, 0).
count_names([], _, Accum) -> Accum;
count_names([H|T], Pos, Accum) ->
    count_names(T, Pos+1, Accum + name_count(H, Pos)).

name_count(Name, Pos) ->
    io:format("Pos: ~p, Name: ~p~n", [Pos, Name]),
    name_sum(Name) * Pos.

name_sum(Name) ->
    L = [X-64 || X <- Name],
    io:format("~p~n", [L]),
    lists:sum(L).
