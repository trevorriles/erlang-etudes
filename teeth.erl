-module(teeth).
-export([alert/1]).

alert(PocketDepths) ->
    lists:reverse(alert(PocketDepths, [], 1)).

alert([], Acc, _) ->
    Acc;
alert([Head | Tail], Acc, Counter) ->
    case lists:max(Head) >= 4 of
        true ->
            alert(Tail, [Counter | Acc], Counter + 1);
        false ->
            alert(Tail, Acc, Counter + 1)
    end.
