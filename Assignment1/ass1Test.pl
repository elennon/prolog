% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

:- dynamic group/2, subGroup/1.




%working
subGroup('Honours Degree in Computing').
subGroup('SD year 4').

subGroupList(L) :-
	findall(X, (subGroup(X)) , L).

assg(_,L):-
	subGroupList(L),
	assert(group('Bsc4', L)),
	write(L).



