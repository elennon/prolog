% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

%member(X,[X|T]).
%member(X,[H|T])  :-  member(X,T).


range(I,I,[I]).
range(I,K,[I|L]) :- I < K, I1 is I + 1, range(I1,K,L).

numberListTo(Z):-
	  write('please type a numbers:'),
	  nl,
	  read(X),
	  range(1,X, [1|Z]),
	  write(Z).

