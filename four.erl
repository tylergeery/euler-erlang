-module(four).

-export([lg_pal_prod/0]).

is_palindrome(I) ->
    A = integer_to_list(I),
    B = lists:reverse(A),
    A == B.

get_max(A, B, M, L) ->
    T = A * B,
    case M >= T of
        true -> {M, L};
        false -> case is_palindrome(T) of
            true -> {T, lists:min([A, B])};
            false -> {M, L}
        end
    end.

lg_pal_prod() ->
    lg_pal_prod(999, 999, 0, 0).
lg_pal_prod(A, B, M, L) ->
    io:format("A:~p, B:~p, M:~p~n", [A,B,M]),
    {N, L1} = get_max(A, B, M, L),
    case B > L1 of
        true -> lg_pal_prod(A, B-1, N, L1);
        false -> case A > L1 of
            true -> lg_pal_prod(A-1, 999, N, L1);
            false -> N
        end
    end.
