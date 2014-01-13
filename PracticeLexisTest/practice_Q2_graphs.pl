%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                         %
%         276 Introduction to Prolog                      %
%                                                         %
%         Practice Lexis Test                             %
%                                                         %
%                                                         %
%         Question 2 (graphs)                             %
%                                                         %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Some examples for testing %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

testgraph(g1,
          [b > f, f > c, c > b, g > h, g > g, d, b, f > k, k > f, f > c],
          graph([b,c,d,f,g,h,k],
                [e(b,f),e(c,b),e(f,c),e(f,k),e(g,g),e(g,h),e(k,f)]),
          [n(b,[f]),n(c,[b]),n(d,[]),n(f,[c,k]),n(g,[g,h]),n(h,[]),n(k,[f])]).
testgraph(g2,
          [s, s > r, t, u > r, s > u, u > s, v > u],
          graph([r,s,t,u,v],[e(s,r),e(s,u),e(u,r),e(u,s),e(v,u)]),
          [n(r,[]),n(s,[r,u]),n(t,[]),n(u,[r,s]),n(v,[u])]).
testgraph(g3,
          [p>q, m>q, q>m, m>p, p>p],
          graph([m,p,q],[e(m,p),e(m,q),e(p,p),e(p,q),e(q,m)]),
          [n(m,[p,q]),n(p,[p,q]),n(q,[m])]).


%%%%%%% End of test examples %%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                                                  %
%         Question 2 (graphs)                      %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


%% ------ Add your code to this file here.


edge(_>_).

merge_ordered([], [], []).
merge_ordered(Left, [], Left).
merge_ordered([], Right, Right).
merge_ordered([L|Lr], [R|Rr], [L|Rest]) :-
    L @< R,
    merge_ordered(Lr, [R|Rr], Rest).
merge_ordered([L|Lr], [R|Rr], [R|Rest]) :-
    L @> R,
    merge_ordered([L|Lr], Rr, Rest).
merge_ordered([L|Lr], [R|Rr], Rest) :-
    L = R,
    merge_ordered([L|Lr], Rr, Rest).


split_terms([],_,_,_,_).
split_terms([A>B|Rest], NodeIn, EdgeIn, NodeOut, NewEdge) :-
    edge(Head),
    merge_ordered([e(A,B)], EdgeIn, EdgeOut),
    split_terms(Rest, NodeIn, EdgeOut, NodeOut, NewEdge).


 
hf_to_graph_term([], _).
hf_to_graph_term(HF, Graph) :-
    findall(A > B, HF, Graph).
%hf_to_graph_term([H|Rest], Rest2) :-
%    hf_to_graph_term(Rest, Rest2).
    

    
    






