% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

% Sample program to get input from the user and see if it is valid
square(1,1,e).
square(1,2,m).


getCrd(X,Y) :-
 input('x',X),
 input('y',Y).
getCrd(_,_) :-
 writeln('not valid Co-Ordniates'),!,fail. % Why ??

% get an integer co-ordinate
input(RefString,I) :-
 write('Enter '),write(RefString), write(' Co-ordinate reference '),
 read(I),
 integer(I),!. % See effect if cut is removed

% Not an integer => try again.
input(RefString,I) :-
 write('number must be entered, followed by full stop'),
 input(RefString,I).
