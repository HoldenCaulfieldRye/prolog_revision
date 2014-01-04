maxi(A, B, Max):-
	\+ A < B,
	Max = A.

maxi(A, B, Max):-
	 A < B,
	Max = B.

max(E,[E]).

max(E,[H|T]):-
	max(X, T),
	maxi(H, X, E).