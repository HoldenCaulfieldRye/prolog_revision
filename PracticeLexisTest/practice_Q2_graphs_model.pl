%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 
%                                                  %
%         276 Introduction to Prolog               %
%                                                  %
%         Practice Lexis Test                      %
%                                                  %
%         Question 2 (graphs)                      %
%                                                  %
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 

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


/*
merge_ordered(Left,Right,Merged) :-
   append(Left,Right,Both),
   sort(Both,Merged).
*/

% in what follows the form of the arguments in the 
% second clause makes the two base cases mutually exclusive

merge_ordered([],Right,Right).

merge_ordered([U|Left],[],[U|Left]).

merge_ordered([U|Left],[U|Right],Rest) :-
  merge_ordered(Left,[U|Right],Rest).

merge_ordered([U|Left],[V|Right],[U|Rest]) :-
  U @< V,
  merge_ordered(Left,[V|Right],Rest).

merge_ordered([U|Left],[V|Right],[V|Rest]) :-
  V @< U,  % could leave out and add cuts above
  merge_ordered([U|Left],Right,Rest).


/* Using conditional structures it looks like this:

merge_ordered([],Right,Right).

merge_ordered([U|Left],[],[U|Left]).

merge_ordered([U|Left],[V|Right],Merged) :-
  (
   U = V
   ->
      LeftX = Left, RightX = [U|Right],
      Merged = RestMerged
   ;
   U @< V
   ->
      LeftX = Left, RightX = [V|Right],
      Merged = [U|RestMerged]
   ;
      LeftX = [U|Left], RightX = Right,
      Merged = [V|RestMerged]
  ),
  merge_ordered(LeftX,RightX,RestMerged).

*/


%----- Part (b) hf_to_graph_term/2---------

hf_to_graph_term(Hform, graph(Nodes,Edges)) :-
   hf_to_gt(Hform,[],[],Nodes,Edges).


hf_to_gt([],Nodes,Edges,Nodes,Edges).
hf_to_gt([Item|Rest],NodesIn,EdgesIn,Nodes,Edges) :-
   add_hf_term_to_gt(Item,NodesIn,EdgesIn,NodesX,EdgesX),
   !,       % could be omitted
   hf_to_gt(Rest,NodesX,EdgesX,Nodes,Edges).


add_hf_term_to_gt(X>X,NodesIn,EdgesIn,NodesX,EdgesX) :- !,
   merge_ordered([X],NodesIn,NodesX),
   merge_ordered([e(X,X)],EdgesIn,EdgesX).
add_hf_term_to_gt(X>Y,NodesIn,EdgesIn,NodesX,EdgesX) :- !,
   sort([X,Y], [U,V]), 
   merge_ordered([U,V],NodesIn,NodesX),
   merge_ordered([e(X,Y)],EdgesIn,EdgesX).
add_hf_term_to_gt(Node,NodesIn,EdgesIn,NodesX,EdgesIn) :- 
   % don't need to test Node \= _>_  because of the cuts above
   merge_ordered([Node],NodesIn,NodesX).


/* Alternatively, something like this


add_hf_term_to_gt(Item,NodesIn,EdgesIn,NodesX,EdgesX) :-
  (
   Item = (X>X)    % or Item = >(X,X) if you prefer
   ->
      NewNodes = [X], NewEdges = [e(X,X)]
   ;
   Item = (X>Y)
   ->
      sort([X,Y], NewNodes), NewEdges = [e(X,Y)]
   ;
      NewNodes = [Item], NewEdges = []
  ),
  merge_ordered(NewNodes,NodesIn,NodesX),
  merge_ordered(NewEdges,EdgesIn,EdgesX).

*/



%----- Part (c) graph_term_to_adj_list/2---------

graph_term_to_adj_list(graph(Nodes,Edges),AdjList) :-
   graph_term_to_adj_list(Nodes,Edges,AdjList).


% nodes are already sorted   
graph_term_to_adj_list([],_,[]).
graph_term_to_adj_list([Node|Rest],Edges,AdjList) :-
   gt_node_to_adj_list(Edges,Node,AdjNodes),
   AdjList = [n(Node,AdjNodes)|AdjListRest], 
   % used =/2 above for readability 
   !,    % could be omitted
   graph_term_to_adj_list(Rest,Edges,AdjListRest).

% nodes are already sorted
gt_node_to_adj_list([],_Node,[]).
gt_node_to_adj_list([e(X,Y)|Rest],Node,AdjList) :-
   (X = Node
    -> AdjList = [Y|AdjListRest]
    ;  AdjList = AdjListRest
   ), 
   gt_node_to_adj_list(Rest,Node,AdjListRest).
 


