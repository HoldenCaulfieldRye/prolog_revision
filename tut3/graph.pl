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
