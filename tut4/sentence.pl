article('the').
article('a').
article('an').

noun('boy').
noun('apple').
noun('carrot').
noun('song').

verb('eats').
verb('sings').


sentence([H|T]):-
	[H1|T1] = T,
	noun_phrase([H,H1]),
	verb_phrase(T1).

noun_phrase([A,B]):-
	article(A),
	noun(B).

verb_phrase([H|T]):-
	verb(H),
	(
	 T = []
	;
	 noun_phrase(T)
	).
