last(X, [X]).

last(X, [_|T]):-
	last(X, T).


penultimate(X, [X,_]).

penultimate(X, [_|T]):-
	penultimate(X, T).