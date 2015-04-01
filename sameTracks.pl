% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.

:- dynamic(user/1, song/1, likes/2).

clear :-
	retractall(user(_)),
	retractall(song(_)),
	retractall(likes(_,_)).

assa(Users, L) :-
	clear,
	assa_users(Users),
	same_taste(L).

assa_users([]).
assa_users([[H|[M]]|T]) :-
	assert(user(H)),
	assert(likes(H, M)),
	assa_users(T).

same_taste(L) :-
	findall(X, (likes(X, Trks),checkk(L, Trks)) ,Lst),
	write(Lst).

checkk(L, L1) :-
	inter(L, L1, Rl),
	length(Rl, Rlc),
	Rlc > 1, !.

inter([], _, []).

inter([H1|T1], L2, [H1|Res]) :-
    member(H1, L2),
    inter(T1, L2, Res).

inter([_|T1], L2, Res) :-
    inter(T1, L2, Res).

flatten([],[]).
flatten(X,[X]) :- not(is_list(X)).
flatten([X|Xs],Zs) :-
	flatten(X,Y),
	flatten(Xs,Ys),
	append(Y,Ys,Zs).
