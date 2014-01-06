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


contained(L1, L2):-
	append(L1, _, L2).

contained(L, [_|T]):-
	contained(L, T). 

