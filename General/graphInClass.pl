% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

s(a,b,1).
s(a,c,6).
s(b,d,2).
s(b,e,3).
s(d,x,1).
s(e,x,4).
s(c,f,1).
s(c,g,1).
s(f,x,2).
s(g,x,1).
goall(x).





solvee( Node, Solution)  :-
  depthfirstt([], Node, Solution).


depthfirstt( Path, Node, [Node | Path] )  :-
goall(Node).

depthfirstt( Path, Node, Sol)  :-
shortest_cost(Node, [Result|_]),
s(Result, Node1, _),
\+ member( Node1, Path),
depthfirstt( [Node | Path], Node1, Sol).


shortest_cost(N1, Shortest):-
setof([D,N2], (s(N1, N2,D)) [_|Shortest]).
