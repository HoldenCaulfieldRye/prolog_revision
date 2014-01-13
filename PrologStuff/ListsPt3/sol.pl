all_members([], _).
all_members([H|Tail], L) :- member(H, L), all_members(Tail, L).

pairs([], _).
pairs([H|Tail], [(Less, More) | Rest]) :- 
  Less is H - 1,
  More is H + 1,
  pairs(Tail, Rest).

arbpairs([], _).
arbpairs([H|Tail], [(H, H) | Rest]) :-
  arbpairs(Tail, Rest). 

arbpairs([H|Tail], [(H, Other) | Rest]) :-
  Other is 2*H,
  arbpairs(Tail, Rest). 


replace_wrap([], _).
replace_wrap([H|Tail], [wrap(H) | Rest]) :-
  replace_wrap(Tail, Rest).

even_members([], _).
even_members([_], _).
even_members([_,H|Tail], [H | Rest]) :-
even_members(Tail, Rest).


odd_even_members([], _, _).
odd_even_members([H], [H], _).
odd_even_members([H1, H2 | Tail], [H1 | Rest1], [H2 | Rest2]) :-
  odd_even_members(Tail, Rest1, Rest2).

numbercon(a(X,Y), V) :-
  numbercon(X, L),
  numbercon(Y, R),
  V is L + R.
numbercon(m(X,Y), V) :-
  numbercon(X, L),
  numbercon(Y, R),
  V is L * R.
numbercon(X, X) :- number(X).

numval(A, V) :- numbercon(A, V). 






node(b).
node(g).
node(m).
node(n).
node(p).
node(t).

edge(b,g).
edge(m,n).
edge(m,p).
edge(p,t).
edge(n,t).

connected(X, Y) :- edge(X,Y).
connected(X, Y) :- edge(Y,X).
connected(X, Y) :- edge(X,Z), connected(Z,Y).

con_partsaux([],_).
con_partsaux([H|Tail], List) :- 

checkinlist(X, [H|Tail], NewL) :- member(X, H), append(X, H, NewL).

connected_parts([]).







