
followedBy(A, B, [H|T]):-
	A = H,
	T = [H2|_],
	B = H2.

followedBy(A, B, [_|T]):-
	followedBy(A, B, T).


nextTo(A, B, L):-
	followedBy(A, B, L).

nextTo(A, B, L):-
	followedBy(B, A, L).