-module(a13).
-export([sum_first_10/1]).

sum_first_10(NumList) ->
    Nums = string:tokens(NumList, "\n"),
    binary_sum(lists:map(fun (N) -> list_to_integer(N) end, Nums)).

binary_sum(Nums) when length(Nums) >= 2 ->
    Split = binary_sum(Nums, length(Nums) + 1),
    binary_sum(Split);
binary_sum(Nums) -> Nums.


binary_sum(Nums, L) when length(Nums) >= 2 ->
    [A|B] = Nums,
    [C|D] = B,
    sum_trim(A+C, L) ++ binary_sum(D, L);
binary_sum([A|_], L) ->
    sum_trim(A, L);
binary_sum([], _) -> [].

sum_trim(Sum, L) ->
    [list_to_integer(lists:sublist(integer_to_list(Sum), 1, 10 + L))].
