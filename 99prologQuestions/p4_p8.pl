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

% YOU HAD:

% is_list(L):-
%         L = [_|_].

% my_flatten([X], [X]):-
%         \+ is_list(X).

% my_flatten([H|T], [H|T]):-
%         \+ is_list(H),
%         my_flatten(T,T).

% my_flatten([Y], L):-
%         is_list(Y),
%         my_flatten(Y, L).

% my_flatten([H|T], [H1|T1]):-
%         my_flatten(H, [H2|T2]),
%         H1 = H2,
%         my_flatten(T, L),
%         append([H2|T2], L, [H1|T1]).


is_list(L):-
	L = [_|_].

% another base case (why needed?)
my_flatten([],[]).


% base case
% this is actually a big deal! you had my_flatten([X],[X]) instead
% so it doesn't just work on lists, it works on an element too, and
% it doesn't flatten it, or leave it as it is, but deepens it!
% why? read comments on next predicate
my_flatten(X, [X]):-
	\+ is_list(X).


% recursive
% usual recursive prolog predicate structure is treat the head, then
% recursively call the tail, and append the two.
% but this predicate treats lists, and the head is not a list. so you
% need to bend the rules and assign a list to a treated element.
% incidentally, this does the opposite of flattening for that special
% case. but it works!
my_flatten([X|Xs],Zs):-
	my_flatten(X,Y),
	my_flatten(Xs,Ys),
	append(Y,Ys,Zs).



%%%%%%%% P8 %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% compress([],[]).

compress([X],[X]):-
	\+ is_list(X).

compress([H|T],L):-
	compress(T, L1),
	[H1|_] = T,
	(
	 \+ H1 = H,
	 L = [H|L1]
	;
	 H1 = H,
	 L = L1
	).


