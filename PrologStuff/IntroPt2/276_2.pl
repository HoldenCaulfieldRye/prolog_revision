


path(X, Y) :- arc(X, Y).
path(X, Y) :- arc(X, Z), path(Z, Y).


arc( a, b ).
arc( c, f ).
arc( f, e ).
arc( b, c ).
arc( d, f ).
arc( b, d ).
arc( c, e ).
