:- use_module(library(lists)).

%%%%%%%% Q1 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

decode([], []).

decode([H|T], [H1|T1]):-
	H = bear,
	H1 = double,
	decode(T, T1).

decode([H|T], [H1|T1]):-
	H = cub,
	H1 = agent,
	decode(T, T1).

decode([H|T], [H|T1]):-
	\+ H = cub,
	\+ H = bear,
	decode(T, T1).


%%%%%%%% Q2 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

within(L, M):-
	append(L, _, M).

within(L, [_|T]):-
	within(L, T).


agents(M, D, ListA):-
	decode(M, D),
	setof(X,
	      within([X, is, a, double, agent], D),
	      ListA),
	!;
	ListA = [].

% agents(M, D, []):-
% 	decode(M, D),
% 	length(M, X),
% 	X < 5.

% agents([H1|T1], D, [H1|T2]):-
% 	decode([H1|T1], D),
% 	append([H1, is, a, double, agent], _, [H1|T1]),
% 	agents(T1, _, T2).

% agents([H|T], D, L):-
% 	decode([H|T], D),
% 	\+ append([H, is, a, double, agent], _, L),
% 	agents(T, _, L).


%%%%%%%% Q3 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

count_word(_, [], 0).

count_word(X, [X|T], C):-
	count_word(X, T, N),
	C is N+1.

count_word(X, [H|T], C):-
	\+ X = H,
	count_word(X, T, C).


%%%%%%%% Q4 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

agents_mod(M, ListA):-
	findall(X,
		within([X, is, a, bear, cub], M),
		ListA).

% agents_mod(M, D, ListA):-
% 	decode(M, D),
% 	\+ findall(X,
% 	      within([X, is, a, double, agent], D),
% 	      ListA),
% 	ListA = [].

count_ag_names(M, As):-
	agents_mod(M, ListAg),
	setof((N,C),
	      (member(N, ListAg),
	       count_word(N, M, C)),
	      As),
	!;
	As = [].


%%%%%%%% Q5 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

accusation_counts(M, As):-
	agents_mod(M, ListAg),
	setof((C,N),
	      (member(N, ListAg),
	       count_word(N, ListAg, C)),
	      Ascend),
	reverse(Ascend, As),
	!;
	As = [].


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
