% This buffer is for notes you don't want to save.
% If you want to create a file, visit that file with C-x C-f,
% then enter the text in that file's own buffer.


:- dynamic group/2, subGroup/1, student/3, teacher/2, member_of/2.

clear :-
	retractall(group(_,_)),
	retractall(subGroup(_)),
        retractall(student(_,_,_)),
	retractall(teacher(_,_)),
	retractall(member_of(_,_)).

aGroup(bsc4).
aGroup(bscCommon).
aSub_Group(hdComp).
aSub_Group(sdY4).
aSub_Group(year1Games).
aSub_Group(year1Web).
aSub_Group(year1Software).
aSub_Group(year1Systems).
subject(ai).
subject(game_design).
inGroup(bsc4, [hdComp,sdY4] ).
inGroup(bscCommon, [year1Games, year1Web,year1Software, year1Systems ]).

studentCount(sdY4, 2).
studentCount(hdComp, 2).
studentCount(year1Games, 2).
studentCount(year1Software, 2).
studentCount(year1Web, 2).
studentCount(year1Systems, 2).

ateacher(paul).
ateacher(una).

teaches(paul, ai, bsc4).
teaches(paul, game_design, bscCommon).

room(b1041).
room(b2008).
room(a0006).
holds(b1041, 32).
holds(b2008, 32).
holds(a0006, 140).
type_room(b041, lab).

%get the head of a list(X,[X|List]).
dFirst(X,[X]).
dFirst(X,[X|_]) :- dFirst(X,_).

%list of all sub groups
subGroupList(L) :-
	findall(X, (aSub_Group(X)) , L).

%list of all teachers
teacherList(L) :-
	findall(X, (ateacher(X)) , L).

%list of sub groups in a given group
aSubGroupList(GroupName, L) :-
	findall(X, (inGroup(GroupName, X)) , L).

%saves a group with its sub groups
assertGroup(GroupName,X):-
	aSubGroupList(GroupName, L),
	dFirst(X, L),
	assert(group(GroupName, X)),
	write(X).

loop_groups([],0).
loop_groups([Y|L],N) :-
	loop_groups(L,N1),
	assertGroup(Y, _),
	N is N1 + 1.

assert_All_Groups(L) :-
	findall(X, (aGroup(X)) , L),
	loop_groups(L,_).


%assert each subgroup in list
listLoop([],0).
listLoop([Y|L],N) :-
	listLoop(L,N1),
	write(Y),
	assert(subGroup(Y)),
	N is N1 + 1.

%gets all sub groups then pass to loop through each to assert
assertAllSubGroups(L) :-
	subGroupList(L),
	listLoop(L,_).

%assert each teacher with an id
lpt(_,[],0).
lpt(Seed,[Y|L],N) :-
	lpt(Seed,L,N1),
	write(Y),
	atom_number(ID,N1),
	atom_concat(Seed,ID,LecturerID),
	assert(teacher(LecturerID, Y)),
	N is N1 + 1.

%uses lpt to assert each teacher(from facts) with an id
assertTeachers(L) :-
	teacherList(L),
	lpt('I0000',L,_).

%add a list of students from X to Y into subGroup Z

get_student_id(N) :-
	findall(X, (student(X,_,_)) , L),
	lngth(L , N).

getList(L) :-
	findall(X, (studentCount(X,_)) , L).

lngth([],0).
lngth([_|L],N) :- lngth(L,N1), N is N1 + 1.

lpp(0).
lpp(N) :-
	Next is N - 1,
	lsts(X , Y, N),
	assertStudents('S000', Y, X),
	lpp(Next).

assertStudents(_,0,_).
assertStudents(Seed, N, ClassGroup) :-
	get_student_id(Id),
	atom_number(ID,Id),
	Next is N -1,
	atom_concat(Seed,ID,StudentID),
	atom_concat(student,ID,Name),
	assert(student(StudentID, Name, ClassGroup)),
	assertStudents(Seed, Next, ClassGroup).

lsts(X,Y, N) :-
	findall(X, (studentCount(X,_)) , L),
	at(X, L, N),
	findall(Y, (studentCount(_,Y)) , L2),
	at(Y, L2, N).

seed_students(L) :-
	getList(L),
	lngth(L , N),
	lpp(N).

at(X,[X|_],1).
at(X,[_|L],K) :-
	K > 1,
	K1 is K - 1,
	at(X,L,K1).

%combines the methods above to seed a full data set
%seed_all(L) :-
%	assert_All_Groups(L),
%	assertAllSubGroups(L),
%	assertTeachers(L),
%	seed_students(L) .
%	enter_member_facts(List).

who_teaches_who(Teacher,List) :-
	findall(X, (teaches(Teacher,_,X) ), L),
	get_subgroups(L, List).
	%who_teaches_who(L, List).
%who_teaches_who([]).
enter_member_facts(List) :-
	findall(X, (teaches(_,_,X) ), L),
	get_subgroups(L, List).
	%who_teaches_who(L, List).

get_subgroups([],_).
get_subgroups([X|T], List) :-
	aSubGroupList(X, L),
	dFirst(L1, L),
	lngth(L1 , N),
	assert_memberFacts(L1,X),
	get_students(L1, N,  List),
	get_subgroups(T, List).

get_students(_,0,_).
get_students([X|T], N , List) :-
	Next is N - 1,
	%dFirst(X, T),
	findall(Y, student(Y,_,X), L),
	assert_memberFacts(L,X),
	get_students(T, Next, List).

assert_memberFacts([],_).
assert_memberFacts([H|T], X) :-
	Clause =.. ['member_of'| [X, H]],
	assert(Clause),
	assert_memberFacts(T,X).

%find all memberof(memberof)) of the group a lecturer teaches to
who(Teacher, X, L) :-
	findall(Z, membr_of(Teacher, X, Z)  , L).

membr_of(T, X , Z ):-
	teaches(T,_, X),
	member_of(X , Y ),
	member_of(Y , Z ).
