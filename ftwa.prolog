:- use_module(library(date)).
:- discontiguous(spouse/2).

%% FAMILY DECLARATION -BEGIN TODO Ailenin geri kalani yazilacak

uid(1, 'Ayşe').
uid(2, 'Erdem').
uid(3, 'Erdi').
uid(4, 'Sibel').
uid(5, 'Seda').
uid(6, 'Ali').
uid(7, 'Ali').
uid(8, 'Deniz').
uid(9, 'Melis').
uid(10, 'Ahmet').
uid(11, 'Güneş').
uid(12, 'Seçil').
uid(13, 'Orhan').
uid(14, 'Derya').
uid(15, 'Tolga').


uid(1, 'Ayşe').
uid(2, 'Erdem').
uid(5, 'Seda').
uid(6, 'Ali').
uid(7, 'Ali').
uid(8, 'Deniz'). 



female(1).
female(4).
female(5).
female(8).
female(9).
female(12).
female(14).




birthdate(date(1925,1,1), 1).
birthdate(date(1920,1,1), 2).
birthdate(date(1950,1,1), 3).
birthdate(date(1949,1,1), 4).
birthdate(date(1952,1,1), 5).
birthdate(date(1948,1,1), 6).
birthdate(date(1960,1,1), 7).
birthdate(date(1960,1,1), 8).
birthdate(date(1961,1,1), 9).
birthdate(date(1960,1,1), 10).
birthdate(date(1980,1,1), 11).
birthdate(date(1971,1,1), 12).
birthdate(date(1978,1,1), 13).
birthdate(date(1982,1,1), 14).
birthdate(date(1982,1,1), 15).



%% FAMILY DECLARATION -END


%% RELATIONS DECLARATION -BEGIN

spouse(1, 2).
spouse(3, 4).
spouse(5, 6).
spouse(7, 8).
spouse(9. 10).


child(3, 1).
child(3, 2).

child(5, 1).
child(5, 2).

child(7, 1).
child(7, 2).

child(9, 1).
child(9, 2).


child(11, 3).
child(11, 4).

child(12,5).
child(12,6).

child(13,5).
child(13,6).

child(14 ,7).
child(14, 8).

child(15, 9).
child(15, 10).


%% RELATIONS DECLARATION -END


%% RULES DECLARATION -BEGIN

male(X) :- not(female(X)).

parent(X,Y) :- child(Y,X).

spouse(X,Y) :- spouse(Y,X).

sibling(X,Y) :- child(X,A), child(Y,A), not(X=Y).

anne(X,Y) :- 		parent(X,Y), 	female(X).
baba(X,Y) :- 		parent(X,Y), 	male(X).
ogul(X,Y) :- 		child(X,Y), 	male(X).
kiz(X,Y) :- 		child(X,Y), 	female(X).
erkek_kardes(X,Y) :- 	sibling(X,Y), 	male(X), 	not(older(X,Y)).
kiz_kardes(X,Y) :- 	sibling(X,Y), 	female(X), 	not(older(X,Y)).
abi(X,Y) :- 		sibling(X,Y), 	male(X), 	older(X,Y).
abla(X,Y) :- 		sibling(X,Y), 	female(X), 	older(X,Y).

amca(X,Y) :- 		parent(Z, Y), 	male(Z), 	sibling(X, Z), male(X).
hala(X,Y) :- 		parent(Z, Y), 	male(Z), 	sibling(X, Z), female(X).
dayi(X,Y) :- 		parent(Z, Y), 	female(Z), 	sibling(X, Z), male(X).
teyze(X,Y) :- 		parent(Z, Y), 	female(Z), 	sibling(X, Z), female(X).

yegen(X,Y) :-		sibling(Z, Y), 	parent(Z, X).
kuzen(X,Y) :-		parent(Z, X), 	parent(U, Y), 	sibling(Z,U).

%eniste(X,Y) :-TODO 
%yenge(X,Y) :- TODO

kayinpeder(X,Y) :-	damat(Y,X).	
kayinvalide(X,Y) :-	gelin(Y,X).
damat(X,Y) :- 		parent(Y, Z), 	female(Z), 	spouse_of(Z,X).
gelin(X,Y) :- 		parent(Y, Z), 	male(Z), 	spouse_of(Z,X).

bacanak(X,Y) :-		spouse(X,Z), 	spouse(Y,U), 	male(X), male(Y), female(Z), female(U), sibling(Z,U).
baldiz(X,Y) :-		sibling(X,Z), 	spouse(Z,Y), 	male(Y), female(X), female(Z).
elti(X,Y) :-		spouse(X,Z), 	spouse(Y,U), 	female(X), female(Y), male(Z), male(U), sibling(Z,U).
kayinbirader(X,Y) :-	spouse(Z,Y), 	sibling(Z,X), 	male(X).

%% Set
rel(X, Y, Z) :- spouse(X,Y); anne(X,Y); baba(X,Y); ogul(X,Y); kiz(X,Y); erkek_kardes(X,Y); kiz_kardes(X,Y); abi(X,Y); abla(X,Y); amca(X,Y); hala(X,Y); dayi(X,Y); teyze(X,Y); yegen(X,Y); kuzen(X,Y);
	kayinpeder(X,Y); kayinvalide(X,Y); damat(X,Y); gelin(X,Y); bacanak(X,Y); baldiz(X,Y); elti(X,Y); kayinbirader(X,Y).

%% RULES DECLARATION -END


% add_3_and_double(X,Y) :- Y is (X+3)*2.




%% FUNCTIONS DECLARATION -BEGIN
list:-
	uid(Input, Output),
	write('The UID of '), write(Input),
	write(' is '), write(Output), write('.').

relation(X,Y, RELATION):-
	rel(X, Output),
	write('The position of '), write(Input),
	write(' is '), write(Output), write('.').


% age(+Birthday, -Age)
%
age(UID, Age) :-
	birthdate(date(Y2, M2, D2), UID),
	get_date_time_value(year, Y1),
	get_date_time_value(month, M1),
	get_date_time_value(day, D1),
	A is Y1 - Y2,
	( ( M1 < M2 ; M1 == M2, D1 < D2 ) -> Age is A - 1 ; Age = A).

older(UID, UID2) :-
	birthdate(date(Y2, M2, D2), UID2),
	birthdate(date(Y1, M1, D1), UID),
	(Y1 > Y2; Y1=Y2, M1 > M2; Y1==Y2, M1==M2, D1 > D2).


%% UTILITY FUNCTIONS DECLARATION -BEGIN
get_date_now(Value) :-
 get_time(Stamp),
 stamp_date_time(Stamp, DateTime, local),
 date_time_value(date, DateTime, Value).

get_date_time_value(Key, Value) :-
 get_time(Stamp),
 stamp_date_time(Stamp, DateTime, local),
 date_time_value(Key, DateTime, Value).

%% UTILITY FUNCTIONS DECLARATION -END
%% FUNCTIONS DECLARATION -END
