sumList([], 0).

sumList([H|T], S):-
	sumList(T, Smaller),
	S is Smaller + H.