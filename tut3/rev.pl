rev([], []).

rev([H|T], Rev):-
	rev(T, TailRev),
	append(TailRev, [H], Rev).

