
partition([], _, [], []).

partition([A,B], P, [A], [B]):-
	(
	 P<A,
	 P<B
	;
	 \+ P<A,
	 \+ P<B
	),
	A < B.

partition([A,B], P, [B], [A]):-
	(
	 P<A,
	 P<B
	;
	 \+ P<A,
	 \+ P<B
	),
	\+ A < B.

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


% quicksort([H|T], Sorted):-
% 	partition([H|T], H-1, Parti1, Parti2),
% 	(
% 	 length([H|T])>1,
% 	 (
% 	 Parti1=[H|T]; Parti2=[H|T]
% 	 ),
	 
% 	;
% 	 quicksort(Parti1, Sorted1),
% 	 quicksort(Parti2, Sorted2),
% 	 append(Sorted1, Sorted2, Sorted)
% 	 ).

% quicksort([H|T], Sorted):-
% 	P is H+1,
% 	partition([H|T], P, Parti1, Parti2),
% 	(
% 	 Parti1=[],
% 	 quicksort(Parti2, Sorted)
% 	;
% 	 Parti2=[],
% 	 quicksort(Parti1, Sorted)
% 	;
% 	 quicksort(Parti1, Sorted1),
% 	 quicksort(Parti2, Sorted2),
% 	 append(Sorted1, Sorted2, Sorted)
% 	).


quicksort([H|T], Sorted):-
	 partition([H|T], H, Parti1, Parti2),
	 quicksort(Parti1, Sorted1),
	 quicksort(Parti2, Sorted2),
	 append(Sorted1, Sorted2, Sorted).
