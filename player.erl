-module(player).

play(Cards, Dealer) ->
    receive
        request_card ->
            case length(Cards) of
                0 ->
                    Dealer ! loser;
                _ ->
                    Dealer ! hd(Cards),
                    play(tl(Cards), C)
            end
    end,
    %% Now wait for the result
    %% You either receive cards or you don't
        {result, C} ->
            play(Cards + C, Dealer)
    end.
