edge('a','b').

edge('a','e').

edge('b','c').

edge('e','f').

edge('f','c').

edge('c','d').

edge('f','d').
path(X,Y):-
	edge(X,Y).

path(X,Y):-
	path(X,Z),
	path(Z,Y).

path(X,Y):-
	path(Z,Y),
	path(X,Z).

path3(X, Y, [X,Y]):-
	edge(X,Y).

path3(X, Y, [H|T]):-
	X = H,
	[H1|_] = T,
	path3quick(H1, Y, T),
	edge(H,H1).



path3quick(X, Y, [X,Y]):-
	edge(X,Y).

path3quick(_, Y, [H|T]):-
	[H1|_] = T,
	path3quick(H1, Y, T),
	edge(H,H1).