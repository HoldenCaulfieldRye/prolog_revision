mother('emmanuelle','alexandre').
mother('emmanuelle','paul').
mother('emmanuelle','constantin').

mother('florence','etienne').
mother('florence','timothee').
mother('florence','clement').
mother('florence','raphael').
mother('florence','gabrielle').

mother('valerie','victor').
mother('valerie','bastien').


children(Mother, Childs):-
	findall(Child,
		mother(Mother, Child),
		Childs).

all_children(Childs):-
	findall(Child,
		mother(_, Child),
		Childs).

