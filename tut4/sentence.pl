article('the').
article('a').
article('an').

noun('boy').
noun('apple').
noun('carrot').
noun('song').

verb('eats').
verb('sings').

conjunction('and').
conjunction(',').

adverb('slowly').
adverb('quickly').
adverb('happily').
adverb('gradually').


sentence([H|T]):-
	[H1|T1] = T,
	noun_phrase([H,H1]),
	verb_phrase(T1).

noun_phrase([A,B]):-
	article(A),
	noun(B).

adverb_phrase([H]):-
	adverb(H).

adverb_phrase([H|T]):-
	adverb(H),
	[H1|T1] = T,
	conjunction(H1),
	adverb_phrase(T1).

verb_phrase([H]):-
	verb(H).

verb_phrase([H|T]):-
	verb(H),
	noun_phrase(T).

verb_phrase(L):-
	append(L1, L2, L),
	noun_phrase(L1),!,
	append(L3, [H|T], L2),
	adverb_phrase(L3),
	verb(H),!,
	(
	 T = []
	;
	 noun_phrase(T)
	).

