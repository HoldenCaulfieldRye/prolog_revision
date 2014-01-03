
partition([], _, []).

partition([H|T], P, Partitioned):-
	H < P,
	partition(T, P, RestPartitioned),
	Partitioned = [H|RestPartitioned].

partition([H|T], P, Partitioned):-
	\+ H < P,
	partition(T, P, RestPartitioned),
	append(RestPartitioned, H, Partitioned).

	
% quicksort([A,P,B], Sorted):-
% 	partition(A,P),
% 	partition(B,P),
% 	quicksort(A),
% 	quicksort(B).