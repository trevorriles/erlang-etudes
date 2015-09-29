-module(powers).
-export([raise/2, nth_root/2]).

raise(_, 0) ->
    1;
raise(X, 1) ->
    X;
raise(X, N) when N > 0 ->
    raise(X, N, 1);
raise(X, N) ->
    1.0 / raise(X, -N).


raise(_, 0, Accumulator) ->
    Accumulator;
raise(X, N, Accumulator) ->
    raise(X, N - 1, X * Accumulator).

nth_root(X, N) ->
    nth_root(X, N, X / 2.0).

nth_root(X, N, A) ->
    io:format("Current guess is ~f~n", [A]),
    F = raise(A, N) - X,
    Fprime = N * raise(A, N - 1),
    Next = A - F / Fprime,
    Change = abs(Next - A),
    if
        Change < 1.0e-8 ->
            Next;
        true ->
            nth_root(X, N, Next)
    end.
