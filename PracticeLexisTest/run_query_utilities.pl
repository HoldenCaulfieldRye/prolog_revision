

run_query(Varnames=Vars:Q) :-
     Varnames=Vars,
     format("~n**testing query: ~w~n", [Q]),
     fail.
run_query(_Varnames=_Vars:Q) :-
     \+ Q, !,
     write('NO SOLUTION'), nl, nl.
run_query(Varnames=Vars:Q) :-
     call(Q),
     format("   ~w = ~w~n", [Varnames,Vars]),
     fail.
run_query(_) :-
     write('No more solutions'), nl, nl.




%%%%%%%%% 

yesno_query(Q) :-
       format("~n**testing query: ~w~n", [Q]),
       (call(Q)
        ->  format("   yes~n", [])
        ;   format("   no~n", [])
       ),
       nl.


%%%%%%%%%%%

% this is called m_forall/2 in case forall/2 is also defined in user file

m_forall(P,Q) :- \+ (P, \+ Q).



