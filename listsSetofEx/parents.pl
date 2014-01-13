parents('jeanne', 'marc', 'bob').
parents('jeanne', 'marc', 'jean').
parents('jeanne', 'marc', 'eleonore').

parents('jeanne', 'julien', 'martine').
parents('jeanne', 'julien', 'patrick').

parents('sophie', 'julien', 'bastien').


half_siblings(Child, Siblings):-
	findall(Sibling,
		(
		 parents(X, _, Child),
		 parents(X, _, Sibling),
		 \+ Child = Sibling
		;
		 parents(_, Y, Child),
		 parents(_, Y, Sibling),
		 \+ Child = Sibling
		),
		Siblings).

%  | ?- half_siblings(jean, HalfSiblings).
%  HalfSiblings = [bob,eleonore,martine,patrick,bob,eleonore] ? ;
%  no

%  -> one list is proposed, combining half-sibling links via
%     various parents. since bob and eleonore have two links
%     to jean, they appear twice.



half_siblings2(Child, Siblings):-
	setof(Sibling,
		(
		 parents(X, _, Child),
		 parents(X, _, Sibling),
		 \+ Child = Sibling
		;
		 parents(_, Y, Child),
		 parents(_, Y, Sibling),
		 \+ Child = Sibling
		),
		Siblings).

% | ?- half_siblings2(jean, HalfSiblings).
% HalfSiblings = [bob,eleonore] ? ;
% HalfSiblings = [martine,patrick] ? ;
% HalfSiblings = [bob,eleonore] ? ;
% no

% -> one list is proposed for each parent through which a
% half-sibling link exists.



% (WRONG) I expect the same output as with half_siblings().
half_siblings3(Child, Siblings):-
	setof(Sibling,
	      (
	       X^parents(X, _, Child),
	       X^parents(X, _, Sibling),
	       \+ Child = Sibling
	      ;
	       Y^parents(_, Y, Child),
	       Y^parents(_, Y, Sibling),
	       \+ Child = Sibling
	      ),
	      Siblings).

% | ?- half_siblings3(jean, HalfSiblings).
% HalfSiblings = [bob,eleonore] ? ;
% HalfSiblings = [martine,patrick] ? ;
% HalfSiblings = [bob,eleonore] ? ;
% no
 


% (WRONG) I expect same output as with half_siblings2().
half_siblings4(Child, Siblings):-
	findall(Sibling,
	      (
	       X^parents(X, _, Child),
	       X^parents(X, _, Sibling),
	       \+ Child = Sibling
	      ;
	       Y^parents(_, Y, Child),
	       Y^parents(_, Y, Sibling),
	       \+ Child = Sibling
	      ),
	      Siblings).

% | ?- half_siblings4(jean, HalfSiblings).
% HalfSiblings = [bob,eleonore,martine,patrick,bob,eleonore] ? ;
% no




siblings(Child, Siblings):-
	findall(Sibling,
		(
		 parents(X, Y, Child),
		 parents(X, Y, Sibling),
		 \+ Child = Sibling
		),
		Siblings).

% | ?- siblings(jean, HalfSiblings).
% HalfSiblings = [bob,eleonore] ? ;
% no

% -> one list is proposed, combining sibling links via all
%     possible parent-couples. since bob and eleonore have
%     one such link to jean, they appear once.


siblings2(Child, Siblings):-
	setof(Sibling,
		(
		 parents(X, Y, Child),
		 parents(X, Y, Sibling),
		 \+ Child = Sibling
		),
		Siblings).

% | ?- siblings(jean, HalfSiblings).
% HalfSiblings = [bob,eleonore] ? ;
% no

% -> one list is proposed for each parent-couple through 
% which a sibling link exists. there is only one such
% parent-couple, so only 1 list is proposed.

% if for some reason, jean and bob were children of 2
% different couples, 2 lists would be proposed here, and
% one list combining both would be proposed above.






% HERE ARE THE ^ TRICKS YOU WERE LOOKING FOR


% | ?- setof(C, parents(_,_,C), Cs).
% Cs = [martine,patrick] ? ;
% Cs = [bob,eleonore,jean] ? ;
% Cs = [bastien] ? ;
% no

% wonder which variable delineates each list?


% | ?- setof(C, parents(X,_,C), Cs).
% X = jeanne,
% Cs = [martine,patrick] ? ;
% X = jeanne,
% Cs = [bob,eleonore,jean] ? ;
% X = sophie,
% Cs = [bastien] ? ;
% no

% shows that each list is for a different X


% | ?- setof(C, X^parents(X,_,C), Cs).
% Cs = [bastien,martine,patrick] ? ;
% Cs = [bob,eleonore,jean] ? ;
% no

% not one combined list!
% instead, now that X is 'blocked', each list is for a
% different Y


% | ?- setof(C, X^parents(X,Y,C), Cs).
% Y = julien,
% Cs = [bastien,martine,patrick] ? ;
% Y = marc,
% Cs = [bob,eleonore,jean] ? ;
% no

% this just shows it explicitly


% | ?- setof(C, Y^X^parents(X,Y,C), Cs).
% Cs = [bastien,bob,eleonore,jean,martine,patrick] ? ;
% no

% now we finally get a combined list!
