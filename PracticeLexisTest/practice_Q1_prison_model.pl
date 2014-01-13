%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                  %
%         276 Introduction to Prolog               %
%                                                  %
%         Practice Lexis Test                      %
%                                                  %
%         Question 1 (prison)                      %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                  %
%         Question 1 (prison)                      %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% compile the Prison Database

:- ensure_loaded(prisonDB_lexis).



cell(N) :-
   cells(Cells),
   in_range(1,Cells,N).


forall(C1, C2) :- \+ (C1, \+ C2).

%% ------ Add your code to this file here.



% assumes that Min and Max are both integers

in_range(Min,Max,Min) :- Min =< Max.
in_range(Min,Max,N) :-
   Min < Max,
   MinX is Min+1,
   in_range(MinX,Max,N).



% --- empty cell

empty_cell(Cell) :- 
  cell(Cell), 
  \+ prisoner(_,_,Cell,_,_,_).


% any cells with all females?
% any of them not single occupant?

all_female_cell(Cell) :-
   cell(Cell), 
   \+ empty_cell(Cell), 
   \+ (prisoner(_,F,Cell,_,_,_), \+ female_name(F)).
   
/* or using forall

all_female_cell(Cell) :-
   cell(Cell), 
   \+ empty_cell(Cell), 
   forall(prisoner(_,F,Cell,_,_,_),
          female_name(F)
         ).
 
*/


% how many female prisoners

female(S,F) :-
  prisoner(S,F,_,_,_,_), 
  female_name(F).

female_prisoners(N) :-
  findall((S,F), female(S,F), Females),
  length(Females,N).
  % question says no need to check for duplicates

% how many prisoners in each cell

cell_occupancy(Cell, N) :-
  cell(Cell),
  findall((S,F), prisoner(S,F,Cell,_,_,_), Occupants),
  length(Occupants, N).

/* 

% using setof instead of forall one has to quantify the variables:

cell_occupancy(Cell, N) :-
  setof((S,F), 
        (Crime,Term,Left)^prisoner(S,F,Cell,Crime,Term,Left),
        Occupants
       ),
  length(Occupants, N).
  
% or define an auxiliary predicate, something like this

cell_occupancy(Cell, N) :-
  cell(Cell),
  setof((S,F), 
        prisoner_in_cell(S,F,Cell),
        Occupants
       ),
  length(Occupants, N).

prisoner_in_cell(S,F,Cell) :-
  prisoner(S,F,Cell,_,_,_).

*/





% Which cell has most occupants?


  
fullest_cell(Cell) :-
  cell_occupancy(Cell,N),
  \+ (cell_occupancy(_,M), M > N).



  
  
 
% Which psychopath is serving longest sentence?

% a useful auxiliary predicate
psychopath(S,F,Crime,T) :-
   psychopath(S,F),
   prisoner(S,F,_,Crime,T,_).

worst_psychopath(S,F,Crime,T) :-
   psychopath(S,F,Crime,T),
   \+ (psychopath(_,_,_,Tx), Tx > T).


/* Without the auxiliary predicate:

worst_psychopath(S,F,Crime,T) :-
   psychopath(S,F,Crime,T),
   prisoner(S,F,_,Crime,T,_)
   \+ (psychopath(Sx,Fx), 
       prisoner(Sx,Fx,_,Crime,Tx,_),
       Tx > T).

*/





% How many murderers? How many plagiarists? 
% How many criminals of type Crime?


criminals(Crime,N) :-
  crimes(Crimes), 
  member(Crime, Crimes),
  findall((S,F), prisoner(S,F,_,Crime,_,_), Criminals),
  length(Criminals, N).

/* Alternatively, using setof, but remember to quantify the variables

criminals(Crime,N) :-
  setof((S,F), 
        (Cell,Term,Left)^prisoner(S,F,Cell,Crime,Term,Left),
        Criminals
       ),
  length(Criminals, N).
  
*/
