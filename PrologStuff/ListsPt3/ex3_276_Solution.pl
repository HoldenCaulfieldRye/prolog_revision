/*

        276 Introduction to Prolog

        Model answers for Exercise 3 (rac/cjh/mjs)

*/

% --------------------  Question 1    all_members/2 ------------------------

    all_members( [], _ ).   % _ is an anonymous variable
    all_members( [X | Rest], List ) :-
        member(X,List),
        all_members( Rest, List ). 



% --------------------  Question 2    pairs/2 ------------------------

    pairs( [], [] ).
    pairs( [N | List], [( Less, More ) | Pairs] ) :-
        Less is N - 1,
        More is N + 1,
        pairs( List, Pairs ). 


% --------------------  Question 3    arbpairs/2 ------------------

    arbpairs( [], [] ).
    arbpairs( [N | List], [(N, N) | Pairs] ) :-
        arbpairs( List, Pairs ). 
    arbpairs( [N | List], [(N, TwoN) | Pairs] ) :-
        TwoN is 2 * N,
        arbpairs( List, Pairs ). 
        
/* Alternatively:

    arbpairs( [], [] ).
    arbpairs( [N | List], [Pair | Pairs] ) :-
        arbpair(N, Pair),
        arbpairs( List, Pairs ). 

    arbpair( N, (N,N) ).
    arbpair( N, (N,TwoN) ) :-
        TwoN is 2 * N.

    You could also use ';' (for 'or') like this:

    arbpairs( [], [] ).
    arbpairs( [N | List], [Pair | Pairs] ) :-
        (Pair = (N,N)
         ;
         Pair = (N, TwoN),
         TwoN is 2 * N
        ),
        arbpairs( List, Pairs ). 

*/

% --------------------  Question 4    replace_wrap/2 ------------------

% The obvious recursive definition:

     replace_wrap( [], [] ).
     replace_wrap( [X|Rest], [wrap(X)|RestOut] ) :-
        replace_wrap( Rest, RestOut ).

% A simple definition using Prolog's findall/3

     replace_wrap_v2(List, RepList) :-
        findall(wrap(X), member(X, List), RepList).


% --------------------  Question 5    even_members/2 ------------------

     even_members([], []).
     even_members([_], []). 
     even_members([_,X|Rest], [X|Evens]) :-
        even_members(Rest, Evens).


% --------------------  Question 6    odd_even_members/2 ------------------

    odd_even([], [], []).
    odd_even([X], [X], []).
    odd_even([X,Y|Rest], [X|Odds], [Y|Evens]) :-
       odd_even(Rest, Odds, Evens).


% --------------------  Question 7    numval/2 ---------------------


    numval( Term, Term ) :-
        number( Term ).   % could put a ! after this call
    numval( a( Term1, Term2 ), Value ) :-
        numval( Term1, Value1 ),
        numval( Term2, Value2 ),
        Value is Value1 + Value2.
    numval( m( Term1, Term2 ), Value ) :-
        numval( Term1, Value1 ),
        numval( Term2, Value2 ),
        Value is Value1 * Value2.


/* Alternatively, convert Term to Prolog arith expression, then evaluate */

   numvalx(Term, Value) :-
      convert_term(Term, PrologExp),
      Value is PrologExp.

 
    convert_term( Term, Term ) :-
        number( Term ).   % could put a ! after this call
    convert_term( a( Term1, Term2 ), (E1 + E2) ) :-
        convert_term( Term1, E1 ),
        convert_term( Term2, E2 ).
    convert_term( m( Term1, Term2 ), (E1*E2) ) :-
        convert_term( Term1, E1 ),
        convert_term( Term2, E2 ).


        



% --------------------  Question 8    connected_parts/1 --------------


% Representation of the graph:
% the nodes are represented by node/1 facts; this allows for the
% representation of graphs with isolated nodes.
% the edges are represented as a pair of nodes.

    node( n ).
    node( t ).
    node( p ).
    node( m ).
    node( g ).
    node( b ).

%  take out the comment on the following fact to test for isolated nodes.

    % node( a ).

    edge( n, t ).
    edge( t, p ).
    edge( n, m ).
    edge( m, p ).
    edge( g, b ).



% This solution keeps a list of components constructed so far
% and looks for any pair that can be joined into one.
% Two components can be joined into one if they have elements
% with an edge between them.
% Procedure terminates when no more reduction/joining can take place.



    connected_parts(Components) :-
       findall([N], node(N), Initial),
       join_components(Initial, Components).
       
    join_components(Now, Now) :-
       \+ join_two_components(Now, _). % a bit inefficient
    join_components(Now, Components) :-
       join_two_components(Now, Reduced),
       join_components(Reduced, Components).


    join_two_components(Now, [Combined|Rest]) :-
       pick_pair(Now, Comp1, Comp2, Rest),
       member(X, Comp1),
       member(Y, Comp2),
       (edge(X, Y) ; edge(Y, X)),
       merge_lists(Comp1, Comp2, Combined).


    pick_pair(List, X, Y, Rest) :-
       select(X, List, Rem),  
       select(Y, Rem, Rest).

% select is provided by Sicstus library(lists) but it is easy.
% It is a generalised version of member/2

    select(X, [X|Y], Y).
    select(X, [U|Y], [U|Z]) :-
       select(X, Y, Z).


% Here is a quick and simple way of merging two (ordered) lists
% sort/2 is a built-in predicate in Prolog.

    merge_lists(Comp1, Comp2, Merged) :-
       append(Comp1, Comp2, Both),
       sort(Both, Merged).  

% Alternatively, write your own merge_lists 
% (cf. add_poly in exercise 2)
       

/* The above could be written more efficiently like this using 'cut':

    join_components(Now, Components) :-
       join_two_components(Now, Reduced), !,   % Note
       join_components(Reduced, Components).
    join_components(Now, Now).


Or alternatively like this (I don't like this):
    
    join_components(Now, Components) :-
       (join_two_components(Now, Reduced)
        ->
           join_components(Reduced, Components)
        ;
           Components = Now
        ).

*/

/* The above can be written slightly more efficiently (tail recursive) 
        
    join_components(Initial, Components) :-
       join_components(go, Initial, Components).
       
    join_components(stop, Now, Now).
    join_components(go, Now, Components) :-
       (join_two_components(Now, Reduced)
        ->
           Next = go
        ;
           Next = stop, Reduced = Now
        ),
        join_components(Next, Reduced, Components).


*/



