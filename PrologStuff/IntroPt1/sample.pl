/*

    MAC/MCSs/MRes 
    Module 531: Laboratory (Prolog)

    Comp2: 276 Introduction to Prolog

    File: sample.pl  -  nr600

*/

check_number( 0 ).
check_number(1).
check_number( N ) :-
    N > 0,
    N1 is N - 2,
    check_number( N1 ).
check_number( N ) :-
    N < 0,
    N1 is N + 2,
    check_number( N1 ).
