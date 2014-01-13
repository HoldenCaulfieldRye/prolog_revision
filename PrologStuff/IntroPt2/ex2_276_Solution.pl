/*

        276 Introduction to Prolog

        Model answers for Exercise 2 cjh/mjs

*/

%% Sicstus 4: member/2 append/3 etc are built-in 


% --------------------- Question 1 --------------------------------

%   An acyclic directed graph is represented by the following facts:

    arc( a, b ).
    arc( b, c ).
    arc( b, d ).
    arc( c, f ).
    arc( d, f ).
    arc( c, e ).
    arc( f, e ).

% 1.a.  path(?X,?Z)

    path( NodeX, NodeZ ) :-
        arc( NodeX, NodeZ ).
    path( NodeX, NodeZ ) :-
        arc( NodeX, NodeY ),
        path( NodeY, NodeZ ).

% 1.b.

/*
    QUERIES     SOLUTIONS

    ?- path( b, f ).        "yes"
    ?- path( b, Z ).        Z/c, Z/d, Z/f (twice), Z/e (thrice)
    ?- path( X, d ).        X/a, X/b
*/

% 1.c.

/*
     QUERIES
 
     i    ?- path( a, d ), path( d, f ). 
     ii   ?- arc( Z, f ), arc( Y, Z ), arc( X, Y ).
          (more efficient than)
          ?- arc( X, Y ), arc(Y, Z), arc( Z, f ).
     iii  ?- path( X, X ).
*/


% --------------------- Question 2 (Peano numbers) ---------------------


% 4.a.    plus(?X,?Y/Z?)

    plus(0, N, N).
    plus( s(X), Y, s(Z) ) :-
        plus( X, Y, Z ).

% 4.b.   % queries


% 4.c.

% N is odd iff N = 2M + 1 for some M
% N is odd iff N = M + (M + 1) for some M
% So ... 

    odd( N ) :-
        plus( M, s(M), N ).



% --------------------- Question 3 --------------------------------

% ones_zeros( ?X ).

    ones_zeros( [] ).
    ones_zeros( [1 | List] ) :-
        ones_zeros( List ).
    ones_zeros( [0 | List] ) :-
        ones_zeros( List ).

/* 
Alternatives:

    ones_zeros( [] ).
    ones_zeros( [X | List] ) :-
        one_or_zero(X),
        ones_zeros( List ).

    one_or_zero(1).
    one_or_zero(0).

Alternatively:

    ones_zeros( [] ).
    ones_zeros( [X | List] ) :-
        (X=1 ; X=0),     % ';' is 'or' in Prolog
        ones_zeros( List ).

Alternatively:

    ones_zeros( [] ).
    ones_zeros( [X | List] ) :-
        member(X, [1,0]),
        ones_zeros( List ).

*/


% --------------------- Question 4 --------------------------------

% hasdups( ?X ).

    hasdups( [Elem | List] ) :-
        member( Elem, List ).
    hasdups( [_ | List] ) :-
        hasdups( List ).

/* try queries
     ?- hasdups(X).
     ?- hasdups([a|X]).
*/

   
% --------------------- Question 5  prod/2 --------------------


    prod( [N], N ).      % could also test number(N)
    prod( [Num|Nums], Prod ) :-
        prod( Nums, TempProd ),
        Prod is Num * TempProd.
        
% tail recursive version:
% NB question forbids preds other than prod/2 and is/2
% so strictly speaking this is  not a correct answer
% (though it is a better program)

    prod_tr( [N|Rest], Prod ) :- 
       prod_tr( Rest, N, Prod).
       
    prod_tr( [], X, X ).
    prod_tr( [N|Rest], Acc, Result ) :-
       NewAcc is Acc * N,
       prod_tr( Rest, NewAcc, Result).



% --------------------- Question 6 contains/3 -----------------

%%  (Draw a picture)

    contains( List, Sublist, Position ) :-
        append( Sublist, _, Back ),
        append( Front, Back, List ),
        length( [_|Front], Position ).


/*
The following also works, but produces the sublists in a
different order

    contains( List, Sublist, Position ) :-
        append( Prefix, Sublist, Front ),
        append( Front, _Back, List ),
        length( [_|Prefix], Position ).

The following works best when the input List is given

    contains( List, Sublist, Position ) :-
        append( Front, Back, List ),   % List is bound here
        append( Sublist, _, Back ),    % so Back is bound here
        length( [_|Front], Position ).

*/

/* Here is a recursive program that doesn't use append and length

    contains( [X|_], [X], 1 ).
    contains( [Elem|List], [Elem|Sublist], 1 ) :-
        contains( List, Sublist, 1 ).
    contains( [_|List], Sublist, Position ) :-
        contains( List, Sublist, Previous ),
        Position is Previous + 1.

You might prefer the following base case instead

    contains( _, [], 1 ).
*/




% --------------------- Question 7      add_poly/3 ----------------

% assumes Poly1 and Poly2 representation has tuples in sorted order

%   add_poly( +Poly1, +Poly2, ?Poly )

    add_poly( [], Poly, Poly ).
    add_poly( Poly, [], Poly ).
    add_poly( [(Coef1,Power)|Tuples1], [(Coef2,Power)|Tuples2],
                    [(Coef, Power)|Tuples] ) :-
        Coef is Coef1 + Coef2,
        add_poly( Tuples1, Tuples2, Tuples ).
    add_poly( [(Coef1,Power1)|Tuples1], [(Coef2,Power2)|Tuples2],
                        [(Coef1, Power1)|Tuples] ) :-
        Power1 > Power2,
        add_poly( Tuples1, [(Coef2,Power2)|Tuples2], Tuples ).
    add_poly( [(Coef1,Power1)|Tuples1], [(Coef2,Power2)|Tuples2],
                        [(Coef2, Power2)|Tuples] ) :-
        Power1 < Power2,
        add_poly( [(Coef1,Power1)|Tuples1], Tuples2, Tuples ).
    
/*
NOTE: with the base cases as written you get two
solutions on backtracking if the two polynomials are
of equal length. You can fix this by replacing the second
base case (say) by:

    add_poly( [X|Poly], [], [X|Poly] ).
*/

/* You can write a tail recursive version too but it is quite ugly */


% Optional part: Here follows one way of sorting the tuples of a poly

% ----------  sort_poly/2 ------

    sort_poly( [], [] ).
    sort_poly( [Tuple|Tuples], Sorted ) :-
        sort_poly( Tuples, SortedTuples ),
        insert_tuple( Tuple, SortedTuples, Sorted ).

    insert_tuple( Tuple, [], [Tuple] ).
    insert_tuple( (Coef1, Power1), [(Coef2, Power2)|Rest],
                        [(Coef1,Power1),(Coef2, Power2)|Rest] ) :-
        Power1 > Power2.
    insert_tuple( (Coef1, Power1), [(Coef2, Power2)|Tuples],
                        [(Coef2, Power2)|Rest] ) :-
        Power1 < Power2,
        insert_tuple( (Coef1, Power1), Tuples, Rest ).



/* NOTE
Sicstus provides built-in predicates sort/2 and keysort/2 for
sorting lists efficiently. (see manual)

Unfortunately, the built-in sort/2 sorts the tuples (C,I) on the value
of C not on the value of I which is what we want here.
(And in the opposite order, but that is not so important.)

For example:
  ?- sort_poly([(2,1),(3,3),(6,0)], X).                     
     X = [(3,3),(2,1),(6,0)] ? ;
     no

but
  ?- sort([(2,1),(3,3),(6,0)], X).     
     X = [(2,1),(3,3),(6,0)] ? ;
     no
 
In order to use the built-in sort/2 therefore we have to do something
like this.

    sort_poly( Poly, Sorted ) :-
       switch_all_tuples( Poly, PolySwitched ),
       sort( PolySwitched, SortedSwitched ),   % built-in
       switch_all_tuples( Sorted, SortedSwitched ).

I omit the details.

But there is another problem with using sort/2. According to the manual,
sort/2 also removes duplicates. That's no good, because e.g. [(2,2),(2,2)]
is 'sort'ed to [(2,2)], which represents a different polynomial.

Sicstus keysort/2 is more general. 
It works on elements of the form Key-Value.
And it does not remove duplicates.

In that case we would need:

    sort_poly( Poly, Sorted ) :-
       tuples_to_key_pairs( Poly, PolyKeys ),
       keysort( PolyKeys, SortedPolyKeys ),   % built-in
       tuples_to_key_pairs( Sorted, SortedPolyKeys ).

       
    tuples_to_key_pairs( [], [] ).
    tuples_to_key_pairs( [(C,I)|Poly], [(I-C)|Switched] ) :-
       tuples_to_key_pairs( Poly, Switched ).
       
Unless the poly lists are very long, the efficiency of poly_sort
isn't going to be significant. You might think that the extra trouble
is not worth it. (I would agree.) On the other hand, if we had chosen
to represent polynomials as lists of elements of the form I-C instead
of (C,I),  we wouldn't need tuples_to_key_pairs/2 and could use
keysort/2 directly.

*/





