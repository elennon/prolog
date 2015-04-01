% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.




 addon(X,List) :-
	X > 0,
	append(List,[X],Z),
	write(Z).
