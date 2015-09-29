-module(non_fp).
-export([generate_teeth/2]).

generate_teeth(String, Prob) ->
    random:seed(erlang:timestamp()),
    generate_teeth(String, Prob, []).

generate_teeth([], _, Acc) ->
    lists:reverse(Acc);
generate_teeth([$T | Tail], Prob, Acc) ->
    NewAcc = [generate_tooth(Prob)|Acc],
    generate_teeth(Tail, Prob, NewAcc);
generate_teeth([$F | Tail], Prob, Acc) ->
    NewAcc = [[0]|Acc],
    generate_teeth(Tail, Prob, NewAcc).

generate_tooth(Prob) ->
    case random:uniform() < Prob of
        true ->
            generate_tooth(2, 6, []);
        false ->
            generate_tooth(3, 6, [])
    end.

generate_tooth(_, 0, Acc) ->
    Acc;
generate_tooth(Base, Num, Acc) ->
    New = Base + random:uniform(3) - 1,
    generate_tooth(Base, Num - 1, [New|Acc]).
