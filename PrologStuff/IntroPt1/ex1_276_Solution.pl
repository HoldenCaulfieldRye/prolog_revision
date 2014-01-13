/*

        276 Introduction to Prolog

        Model answers for Exercise 1.  cjh/nr600/mjs

*/

% 1. Enter the following queries and find all their solutions:

/*
        QUERIES                             SOLUTIONS
        
        ?- child_of( peter, irene ).    none
        ?- child_of( peter, emlyn ).    none
        ?- child_of( X, george ).           X/elizabeth, X/margaret
        ?- child_of( george, Y ).           Y/maurice
        ?- child_of( X, X ).        none
        ?- child_of( X, Y ).        all X, Y such that the database implies child_of( X, Y )
*/

%  2. Add further Prolog clauses which define the following predicates:

%   "M is mother of X"

    mother_of( Mother, X) :-
        child_of( X, Mother ),
        female( Mother ).


%   "X is a grandparent of Y" 

    grandparent_of( GrandParent, Person) :-
        child_of( Parent, GrandParent ),
        child_of( Person, Parent ).    


%   "X is a daughter of Y"

    daughter_of( Daughter, Parent) :-
        child_of( Daughter, Parent ),
        female( Daughter ).

%   "X is an uncle of Y"

    uncle_of( Uncle, Person) :-
        child_of( Person, Parent),
        sibling_of( Uncle, Parent ),
        male( Uncle ).

    uncle_of( Uncle, Person) :-
        child_of( Person, Parent),
        sibling_of( Aunt, Parent ),
        married_to( Uncle, Aunt ),
        male( Uncle ).

    sibling_of( Child1, Child2 ) :-
        child_of( Child1, Parent ),
        child_of( Child2, Parent ),
        Child1 \= Child2.

    married_to( Spouse1, Spouse2 ) :-
        child_of( Child, Spouse1 ),
        child_of( Child, Spouse2 ),
        Spouse1 \= Spouse2.

/*
NOTE: the only way marriage can be inferred from this database
is by comparing parents

Alternative formulation:

    married_to( Father, Mother ) :-
        child_of( Child, Father ),
        male(Father),
        child_of( Child, Mother ),
        female(Mother).

*/

%   "X is a niece of Y"

    niece_of( Niece, Person) :-
        uncle_of( Person, Niece ),
        female( Niece ).

    niece_of( Niece, Person) :-
        aunt_of( Person, Niece ),
        female( Niece ).



%   "GGf is a great-grandfather of X" 

    great_grandfather_of( GreatGrandFather, Person) :-
        child_of( GrandParent, GreatGrandFather ),
        male( GreatGrandFather ),
        child_of( Parent, GrandParent ),
        child_of( Person, Parent ).

/* obviously we could also have written e.g.

    great_grandfather_of( GreatGrandFather, Person) :-
        child_of( GrandParent, GreatGrandFather ),
        grandparent_of( GrandParent, Person),
        male( GreatGrandFather ).

%% or

    great_grandfather_of( GreatGrandFather, Person) :-
        child_of( Person, Parent ),
        grandparent_of( GreatGrandFather, Parent),
        male( GreatGrandFather ).

*/

%   "Anc is an ancestor of X" 

    ancestor_of( Anc, X) :-
        child_of( X, Anc ).
    ancestor_of( Anc, X) :-
        child_of( X, Y ),
        ancestor_of( Anc, Y).

/* or alternatively


    ancestor_of( Anc, X) :-
        child_of( X, Anc ).
    ancestor_of( Anc, X) :-
        child_of( Y, Anc ),
        ancestor_of( Y, X).

*/


