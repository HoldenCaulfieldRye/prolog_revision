andgate('And').

orgate('Or').

xorgate('Xor').

input1('And', 1).

input2('And', 0).

input1('Or', 1).

input2('Or', 0).

input1('Xor', 1).

input2('Xor', 0).



% and gate
output(G,1):-
	andgate(G),
	input1(G,1),
	input2(G,1).

output(G,0):-
	andgate(G),
	\+ output(G,1).


% or gate
output(G,0):-
	orgate(G),
	input1(G,0),
	input2(G,0).

output(G,1):-
	orgate(G),
	\+ output(G,0).



% xor gate
output(G,1):-
	xorgate(G),
	(
	 input1(G,1),
	 input2(G,0)
	;
	 input1(G,0),
	 input2(G,1)
	).

output(G,0):-
	xorgate(G),
	\+ output(G,1).

	 

