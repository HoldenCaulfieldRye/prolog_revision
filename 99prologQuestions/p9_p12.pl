%%%%%%%% P9 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% followed(X, Y, [H|T]):-
% 	X = H,
% 	[Y|_] = T.

% followed(X, Y, [_|T]):-
% 	followed(X, Y, T).

% adjacent(X, Y, L):-
% 	followed(X, Y, L).

% adjacent(X, Y, L):-
% 	followed(Y, X, L).

pack([X], [[X]]):-
	\+ is_list(X).

% if an element of the head of the packed list of T is equal to H, then
% H1 is [H] appended by the head of the packed list of T,
% and T1 is the tail of the packed list of T.
pack([H|T], [H1|T1]):-
	pack(T, [H2|T2]),
	[X|_] = H2,
	X = H,
	H1 = [H|H2],
	T1 = T2.

% if an element of the head of the packed list of T is not equal to H, then 
% H1 is [H],
% and T1 is the packed list of T.
pack([H|T], [H1|T1]):-
	pack(T, [H2|T2]),
	[X|_] = H2,
	\+ X = H,
	H1 = [H],
	T1 = [H2|T2].


%%%%%%%% P10/P11 %%%%%%%%%%%%%%%%%%%%%%%%%%

convert_one([X], X):-
	length([X], 1).

convert_one(H, [X,Y]):-
	length(H, X),
	\+ X is 1,
	[Y|_] = H.


convert([],[]).

convert([H1|T1], [H2|T2]):-
	convert_one(H1, H2),
	convert(T1, T2).


encode_modified(L1, L2):-
	pack(L1, L),
	convert(L, L2).


%%%%%%%% P12 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

