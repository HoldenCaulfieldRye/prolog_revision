last(X, [X]).

last(X, [_|T]):-
	last(X, T).


penultimate(X, [X,_]).

penultimate(X, [_|T]):-
	penultimate(X, T).


% element_at(X, L, Pos):-
% 	length(L, Pos),
% 	last(X, L).

element_at(X, [H|T], Pos):-
	length([H|T], Length),
	Length >= Pos,
	append(L, _, [H|T]),
	length(L, Pos),
	last(X, L).