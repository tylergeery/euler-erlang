-module(a19).
-export([sundays/0, gather/1]).

gather(Count) ->
    receive
        sunday -> gather(Count+1);
        complete ->
            io:format("Final count: ~p~n", [Count])
    end.

sundays() ->
    GATHER_PID = spawn(a19, gather, [0]),
    count(GATHER_PID, {1900, 1, 1, monday}).

count(GATHER_PID, {2000, _, _, _}) ->
    GATHER_PID ! complete;
count(GATHER_PID, {Year, Month, 1, sunday}) ->
    io:format("~p-~p-~p-~p~n", [Year, Month, 1, sunday]),
    GATHER_PID ! sunday,
    count(GATHER_PID, get_next_date({Year, Month, 1, sunday}));
count(GATHER_PID, {Year, Month, Day, Atom}) ->
    count(GATHER_PID, get_next_date({Year, Month, Day, Atom})).

get_next_date({Year, 2, 28, Atom}) when Year rem 4 == 0, Year rem 100 =:= 0 ->
    {Year, 2, 29, get_next_day(Atom)};
get_next_date({Year, 2, 28, Atom}) when Year rem 100 == 0, Year rem 400 == 0 ->
    {Year, 2, 29, get_next_day(Atom)};
get_next_date({Year, 2, Day, Atom}) when Day >= 28 ->
    {Year, 3, 1, get_next_day(Atom)};
get_next_date({Year, Month, 30, Atom}) when Month == 4; Month == 6; Month == 9; Month == 11 ->
    {Year, Month+1, 1, get_next_day(Atom)};
get_next_date({Year, 12, 31, Atom}) ->
    {Year+1, 1, 1, get_next_day(Atom)};
get_next_date({Year, Month, 31, Atom}) ->
    {Year, Month+1, 1, get_next_day(Atom)};
get_next_date({Year, Month, Day, Atom}) ->
    {Year, Month, Day+1, get_next_day(Atom)}.

get_next_day(Atom) ->
    case Atom of
        monday -> tuesday;
        tuesday -> wednesday;
        wednesday -> thursday;
        thursday -> friday;
        friday -> saturday;
        saturday -> sunday;
        sunday -> monday
    end.
