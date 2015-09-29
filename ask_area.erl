-module(ask_area).
-export([area/0]).

area() ->
    ShapeIn = io:get_line("R)ectangle, T)riangle, or E)llipse > "),
    Shape = char_to_shape(hd(ShapeIn)),
    case Shape of
        rectangle ->
            Dimensions = get_dimensions("width", "height");
        triangle ->
            Dimensions = get_dimensions("base", "height");
        ellipse ->
            Dimensions = get_dimensions("major axis", "minor axis");
        unknown ->
            Dimensions = {error, "unknown shape " ++ [hd(ShapeIn)]}
    end,

    Area = calculate(Shape, element(1, Dimensions), element(2, Dimensions)),
    Area.

calculate(unknown, _, Err) -> io:format("~s~n", [Err]);
calculate(_, error, _) -> io:format("Error in first number.~n");
calculate(_, _, error) -> io:format("Error in second number.~n");
calculate(_, A, B) when A < 0; B < 0 ->
    io:format("Both numbers must be greater than or equal to zero~n");
calculate(Shape, A, B) ->
    geom:area(Shape, A, B).

get_dimensions(P1, P2) ->
    X = get_number(io:get_line("Enter " ++ P1 ++ " > ")),
    Y = get_number(io:get_line("Enter " ++ P2 ++ " > ")),
    {X, Y}.

-spec(get_number(string()) -> number()).

get_number(String) ->
    case string:to_float(String) of
        {error, _} ->
            {Num, _} = string:to_integer(String),
            Num;
        {Num, _} ->
            Num
    end.


-spec(char_to_shape(char()) -> atom()).

char_to_shape($T) -> triangle;
char_to_shape($t) -> triangle;
char_to_shape($R) -> rectangle;
char_to_shape($r) -> rectangle;
char_to_shape($E) -> ellipse;
char_to_shape($e) -> ellipse;
char_to_shape(_) -> unknown.
