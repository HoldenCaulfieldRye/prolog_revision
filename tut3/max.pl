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



max_of_all(E, [List]):-
	max(E, List).

max_of_all(E, [HList|TList]):-
	HList = [],
	max_of_all(E, TList).

max_of_all(E, [HList|TList]):-
	max_of_all(X, TList),
	max(Y, HList),
	maxi(X, Y, E).