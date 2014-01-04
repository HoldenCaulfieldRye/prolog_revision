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



max_of_all(E, [[E]]).

max_of_all(E, [HList|TList]):-
	max_of_all(X, TList),
	max(Y, HList),
	maxi(X, Y, E).