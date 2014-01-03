
followedBy(A, B, [H|T]):-
	A = H,
	T = [H2|_],
	B = H2.

followedBy(A, B, [_|T]):-
	followedBy(A, B, T).