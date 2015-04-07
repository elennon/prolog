% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

:- dynamic(user/1, song/1, likes/2).

clear :-
	retractall(user(_)),
	retractall(song(_)),
	retractall(likes(_,_)).

fillDb(Users) :-
	clear,
	assa_users(Users),!.

assa_users([]).
assa_users([[H|[M]]|T]) :-
	assert(user(H)),
	assert(likes(H, M)),
	assa_users(T).


