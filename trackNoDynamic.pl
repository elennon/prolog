% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.


user(larry).
user(mo).
user(curly).
likes(larry, [s1,s2,s3,s4,s5,s6,s7]).
likes(mo,    [s1,s2,s3,s24,s25,s26,s27]).
likes(curly, [s1,s2,s3,s4,s5,s6,s27]).


same_taste(L) :-
	findall(X, (likes(X, Trks),checkk(L, Trks)) ,Lst),
	write(Lst).

checkk(L, L1) :-
	inter(L, L1, Rl),
	length(Rl, Rlc),
	Rlc > 1,!.

inter([], _, []).

inter([H1|T1], L2, [H1|Res]) :-
    member(H1, L2),
    inter(T1, L2, Res).

inter([_|T1], L2, Res) :-
    inter(T1, L2, Res).
