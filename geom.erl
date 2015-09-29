%% @author Trevor Riles <trevor@riles.io>
%% @doc Functions for calculating areas of geometric shapes.
%% @version 0.1

-module(geom).
-export([area/1, area/3]).

area({Shape, X, Y}) ->
    area(Shape, X, Y).

%% @doc Calculates the area of a rectangle, triangle, or ellipse,
%% given the length and width. Returnes the product of its
%% arguments.

-spec(area(atom(), number(),number()) -> number()).

area(Shape, X,Y) when X > 0, Y > 0 ->
    case Shape of
        rectangle ->
            X * Y;
        triangle ->
            X * Y / 2.0;
        ellipse ->
            math:pi() * X * Y;
        _ ->
            0
    end.
