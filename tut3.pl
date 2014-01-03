
partition([], _, [], []).


partition([H|T], P, Parti1, Parti2):-
	H < P,!,
	partition(T, P, RestParti1, Parti2),
	Parti1 = [H|RestParti1].

partition([H|T], P, Parti1, Parti2):-
	\+ H < P,
	partition(T, P, Parti1, RestParti2),
	Parti2 = [H|RestParti2].



quicksort([], []).

% need to avoid infinite loop (you can visualise this)
quicksort([H|[]], [H]).


quicksort([H|T], Sorted):-
	 partition([H|T], H, Parti1, Parti2),
	 (
	  [H|T]=Parti1,
	  quicksort(T, Sorted1),
	  Sorted=[H|Sorted1]
	 ;
	  quicksort(Parti1, Sorted1),
	  quicksort(Parti2, Sorted2),
	  append(Sorted1, Sorted2, Sorted)
	 ).
