% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

split([],[]).

split([X|List] , [X|Negative]) :-
        X < 0,
        split(List,Negative).

