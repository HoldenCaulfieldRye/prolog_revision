%%%%%%%% P4 %%%%%%%%%%%%%%%

len([], 0).

len([_|T], X):-
	len(T, Y),
	X is Y+1.


%%%%%%%% P5 %%%%%%%%%%%%%%%

rev([X], [X]).

rev([H|T], L):-
	rev(T, L1),
	append(L1, L2, L),
	L2 = [H].


%%%%%%%% P6 %%%%%%%%%%%%%%%

palindrome(L):-
	rev(L,L).


%%%%%%%% P7 %%%%%%%%%%%%%%%

is_list(L):-
	L = [_|_].

% base case
my_flatten([X], [X]):-
	\+ is_list(X).

% case where list is already flat
my_flatten([H|T], [H|T]):-
	\+ is_list(H),
	my_flatten(T,T).

% case where list is one single clogged up element
my_flatten([Y], L):-
	is_list(Y),
	my_flatten(Y, L).


my_flatten([H|T], [H1|T1]):-
	my_flatten(H, [H2|T2]),
	H1 = H2,
	my_flatten(T, L),
	append([H2|T2], L, [H1|T1]).
	
	


% my_flatten(L, [X]):-
% 	member(X, L1),
	

	