
split([],[],[]).
split([X|List] , Positive , [X|Negative]) :-
        X < 0,
        split(List,Positive,Negative).
split([X|List] , [X|Positive] , Negative) :-
        X >= 0,
        split(List,Positive,Negative).

numberList(Z) :-
	  write('please type a numbers:'),
	  nl,
	  read(X),
	  split(X,A,_),
	  append([],A,Z),
	  write(Z).
