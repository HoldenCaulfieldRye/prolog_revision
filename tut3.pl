mysort([X], [X]).

mysort([H|T], SortedA):-


partition([], P, []).

partition([H|T], P, Partitioned):-
	H < P,
	Partitioned = [H|RestPartitioned],
	partition(T, P, RestPartitioned).

partition([H|T], P, Partitioned):-
	\+ H < P,
	Partitioned = [RestPartitioned, H],
	partition(T, P, RestPartitioned).

	
% quicksort([A,P,B], Sorted):-
% 	partition(A,P),
% 	partition(B,P),
% 	quicksort(A),
% 	quicksort(B).