followedBy([], [X], [X|_]).

followedBy([], [H2|T2], [H3|T3]):-
	H2=H3,
	followedBy([], T2, T3).
	
followedBy([H1|T1], [H2|T2], [H3|T3]):-
	\+ H1 = H3,
	followedBy([H1|T1], [H2|T2], T3).

followedBy([H1|T1], [H2|T2], [H3|T3]):-
	H1 = H3,
	(
	 followedBy([H1|T1], [H2|T2], T3)
	;
	 followedBy(T1, [H2|T2], T3)
	).


contained(H, [H|T]).

contained([H1|T1], [H|T]):-
	H1 = H,
	contained(T1, T).

contained(L, [H|T]):-
	contained(L, T). 

