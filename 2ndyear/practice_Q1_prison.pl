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


%%%%%%%% a %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

in_range(Min, Max, Min):-
	Min =< Max.

in_range(Min, Max, N):-
	X is Min+1,
	\+ X > Max,
	in_range(X, Max, N).


%%%%%%%% b %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

empty_cell(Cell):-
	in_range(1, 132, Cell),
	\+ prisoner(_, _, Cell, _, _, _).


%%%%%%%% c %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

all_female_cell(Cell):-
	in_range(1, 132, Cell),
	forall(prisoner(_, Name, Cell, _, _, _),
			female_name(Name)).


%%%%%%%% d %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

female_prisoners(N):-
	findall(Name,
		(
		 prisoner(_, Name, _, _, _, _),
		 female_name(Name)
		),
		Females),
	length(Females, N).

male_prisoners(N):-
	findall(Name,
		(
		 prisoner(_, Name, _, _, _, _),
		 \+ female_name(Name)
		),
		Males),
	length(Males, N).

prisoners(N):-
	findall(Name,
		prisoner(_, Name, _, _, _, _),
		Prisoners),
	length(Prisoners, N).


%%%%%%%% e %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cell_occupancy(Cell, N):-
	in_range(1, 132, Cell),
	findall(Local,
		prisoner(_, Local, Cell, _, _, _),
		Locals),
	length(Locals, N).


%%%%%%%% f %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cell_sizes(CellSizes):-
	setof(NegCellSize,
	      CellSize^X^(cell_occupancy(X, CellSize),
			  NegCellSize is -CellSize),
	      CellSizes).
	

fullest_cell(Cell):-
	in_range(1, 132, Cell),
	cell_occupancy(Cell, Size),
	cell_sizes([H|_]),
	Size is -H.
	

%%%%%%%% g %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%




/*  Remove the following comments if you wish to skip part(a) */

/*  

% load the library(between) module

:- use_module(library(between)).

in_range(Min, Max, N) :- between(Min, Max, N).

*/

%% ------ Add your code to this file here.
 
