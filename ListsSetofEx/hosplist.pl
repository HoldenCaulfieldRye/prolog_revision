hosp_list(L, NHS, Priv):-
	findall((HospName, nhs),
	      member((HospName, nhs), L),
	      NHS),
	findall((HospName, private),
	      member((HospName, private), L),
	      Priv).