
q(X,Y) :- X > 0, Y > 0, X < 9, Y < 9.

no_attack([], _).
no_attack([q(X,Y) | Tail], q(M,N)) :- 
	N \= Y, 
	X \= M,
	no_attack(Tail, q(M,N)). 
