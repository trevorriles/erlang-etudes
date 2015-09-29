-module(dates).
-export([date_parts/1, julian/1]).

-spec(date_parts(string()) -> [string()]).
date_parts(ISO) ->
    [Year, Month, Day] = re:split(ISO, [$-], [{return, list}]),
    {YearInt, _} = string:to_integer(Year),
    {MonthInt, _} = string:to_integer(Month),
    {DayInt, _} = string:to_integer(Day),
    [YearInt, MonthInt, DayInt].

julian(ISO) ->
    [Year, Month, Day] = date_parts(ISO),
    FebDays = case is_leap_year(Year) of
        true ->
            29;
        false ->
            28
    end,
    DaysPerMonth = [31, FebDays, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31],
    {TMP, _} = lists:split(Month - 1, DaysPerMonth),
    lists:foldl(fun(X, Y) -> X + Y end, 0, TMP) + Day.

is_leap_year(Year) ->
    (Year rem 4 == 0 andalso Year rem 100 /= 0) orelse (Year rem 400 == 0).
