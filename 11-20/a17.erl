-module(a17).
-export([letter_count/1, letters/1]).

letter_count(N) ->
    lists:sum(number_counts(N)).

letters(N) ->
    [word(X) || X <- lists:seq(1, N)].

number_counts(N) ->
    [length(word(X)) || X <- lists:seq(1, N)].

word(0) -> "";
word(1000) -> "onethousand";
word(N) when N >= 100 ->
    Rem = N rem 100,
    Prefix = word(trunc(N/100)),
    case Rem == 0 of
        true -> Prefix ++ "hundred";
        false -> Prefix ++ "hundredand" ++ word(N rem 100)
    end;
word(N) when N >= 20 ->
    case trunc(N/10) of
        2 -> "twenty" ++ word(N rem 10);
        3 -> "thirty" ++ word(N rem 10);
        4 -> "forty" ++ word(N rem 10);
        5 -> "fifty" ++ word(N rem 10);
        6 -> "sixty" ++ word(N rem 10);
        7 -> "seventy" ++ word(N rem 10);
        8 -> "eighty" ++ word(N rem 10);
        9 -> "ninety" ++ word(N rem 10)
    end;
word(N) when N > 0 ->
    case N of
        1 -> "one";
        2 -> "two";
        3 -> "three";
        4 -> "four";
        5 -> "five";
        6 -> "six";
        7 -> "seven";
        8 -> "eight";
        9 -> "nine";
        10 -> "ten";
        11 -> "eleven";
        12 -> "twelve";
        13 -> "thirteen";
        14 -> "fourteen";
        15 -> "fifteen";
        16 -> "sixteen";
        17 -> "seventeen";
        18 -> "eighteen";
        19 -> "nineteen"
    end.
