%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                         %
%         276 Introduction to Prolog                      %
%                                                         %
%         Practice Lexis Test                             %
%                                                         %
%         Question 1 (prison)                             %
%                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                         %
%         Question 1 (prison)                             %
%                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% compile the Prison Database

:- ensure_loaded(prisonDB_lexis).

forall(C1,C2) :- \+ (C1, \+ C2).

cell(N) :-
   cells(Cells),
   in_range(1,Cells,N).

in_range(Min, Max, Max) :-
    Min =< Max.
in_range(Min, Max, N) :-
    Min =< Max, 
    NewMax is Max - 1,
    in_range(Min, NewMax, N).

empty_cell(Cell) :- 
    cell(Cell), 
    \+ prisoner(_, _, Cell, _, _, _).


all_female_cell(Cell) :-
    cell(Cell),
    forall(prisoner(_, FName, Cell, _, _, _), female_name(FName)), 
    (\+ empty_cell(Cell)). 

list_of_female(X) :- 
    findall(N, (prisoner(_, N, _, _, _, _), female_name(N)), X).  

female_prisoners(N) :-
    list_of_female(X), 
    length(X, N).

list_in_cell(Cell, X) :-
    cell(Cell),
    findall(Cell, (prisoner(_, _, Cell, _, _, _)), X).

cell_occupancy(Cell, N) :-
    list_in_cell(Cell, X),
    length(X, N).
    

fullest_cell(Cell) :-
    cell_occupancy(Cell, N), 
    \+ (cell_occupancy(_, M), M > N).


worst_physcopath(S, F, Crime, T) :- 
    prisoner(S, F, _, Crime, T, _),
    psychopath(S, F),
    \+ (prisoner(S1, F1, _, _, T1, _), psychopath(S1, F1), T1 > T).

criminals(Crime, N) :-
    crimes(C),
    member(Crime, C),
    findall(Crime, (prisoner(_,_,_,Crime,_,_)), X),
    length(X, N).


 

/*  Remove the following comments if you wish to skip part(a) */

/*  

% load the library(between) module

:- use_module(library(between)).

in_range(Min, Max, N) :- between(Min, Max, N).

*/

%% ------ Add your code to this file here.
 
