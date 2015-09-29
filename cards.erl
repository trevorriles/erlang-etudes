-module(cards).
-export([make_deck/0]).

make_deck() ->
    Names = ["A", 2, 3, 4, 5, 6, 7, 8, 9, 10, "J", "K", "Q", "K"],
    Suits = ["Clubs", "Diamonds", "Hearts", "Spades"],
    [{Name, Suit} || Name <- Names, Suit <- Suits].

%% shuffle takes a list of cards, then randomly splits the deck,
%% adding the top card to the accumulator.
shuffle(List) ->
    shuffle(List, []).
shuffle([], Acc) ->
    Acc;
shuffle(List, Acc) ->
    {Leading, [H | T]} = lists:split(random:uniform(length(List)) - 1, List),
    shuffle(Leading ++ T, [H | Acc]).
