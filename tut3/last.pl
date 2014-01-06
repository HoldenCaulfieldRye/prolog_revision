last(E, [H|T]):-
	T = [],
	E = H.

last(E, [_|T]):-
	\+ T = [],
	last(E, T).
