-module(stats).
-export([minimum/1, maximum/1, mean/1, stdv/1]).

range(List) ->
    [minimum(List), maximum(List)].

-spec(minimum([number()]) -> number()).
minimum([Head | Tail]) ->
    minimum(Tail, Head).

-spec(minimum([number()], number()) -> number()).
minimum([], Min) ->
    Min;
minimum([Head | Tail], Min) ->
    if
        Head < Min ->
            minimum(Tail, Head);
        true ->
            minimum(Tail, Min)
    end.

-spec(maximum([number()]) -> number()).
maximum([Head | Tail]) ->
    maximum(Tail, Head).

-spec(maximum([number()], number()) -> number()).
maximum([], Max) ->
    Max;
maximum([Head | Tail], Max) ->
    if
        Head > Max ->
            maximum(Tail, Head);
        true ->
            maximum(Tail, Max)
    end.

mean(NumList) ->
    lists:foldl(fun(X, Y) -> X + Y end, 0, NumList) / length(NumList).

stdv(NumList) ->
    N = length(NumList),
    {Sum, SumOfSquares} = lists:foldl(fun(X, {S, SoS}) -> {X + S, X*X + SoS} end, {0, 0}, NumList),
    math:sqrt(((N * SumOfSquares) - (Sum * Sum)) / (N * (N - 1))).
