last(E, [H|T]):-
	T = [],
	E = H.

last(E, [H|T]):-
	\+ T = [],
	E = H.
