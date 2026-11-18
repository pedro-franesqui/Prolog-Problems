% P1 - Find last element of a list

my_last(null, []).
my_last(X, [X]).
my_last(X, [_|T]) :- my_last(X, T).


% P2 - Find last but one element of a list

my_last_but_one(X, [X, _]).
my_last_but_one(X, [_|T]) :- my_last_but_one(X, T).


% P3 - Find kth element of a list

element_at(X, [X|_], 1).
element_at(X, [_|T], K) :-
    K > 1,
    Kprev is K - 1,
    element(X, T, Kprev).


% P4 - Find number of elements of a list

list_length([], 0).
list_length([_|T], X) :- 
    list_length(T, X2),
    X is X2 + 1.


% P5 - Reverse a list

append([], L, L).
append([H|L1], L2, [H|L3]) :- append(L1, L2, L3).

naive_rev([], []).
naive_rev([H|T], R) :-
    naive_rev(T, RT),
    append(RT, [H], R).

rev_acc([], L, L).
rev_acc([H|T], Acc, Rev) :-
    rev_acc(T, [H|Acc], Rev).

reverse(L1, L2) :- rev_acc(L1, [], L2).


% P6 - Find out whether list is palindrome

palindrome(L) :- reverse(L, L).


% P7 - Flatten nested list

my_flatten([], []).
my_flatten(X, [X]) :- \+ is_list(X).
my_flatten([H|T], L) :-
    my_flatten(H, FH),
    my_flatten(T, FT).
    append(FH, FT, L).


% P8 - Eliminate consecutive duplicates of list elements

compress([], []).
compress([X], [X]).
compress([X,X|T], L) :- compress([X|T], L)
compress([X,Y|T], [X|Z]) :- 
    X \= Y,
    compress([Y|T], Z).


% P9 - Pack consecutive duplicate list elements into sublists

pack([], []).
pack([X], [[X]]).
pack([Head|Tail], [[Head, Head | X] | Y]) :- pack(Tail, [[Head|X] | Y]).
pack([Head|Tail], [[Head], [Z|X] | Y]) :- 
    pack(Tail, [[Z|X] | Y]),
    X \= Y.


% P10 - Run length encoding of a list

encode([], []).
encode([X], [[1, X]]).
encode([Head|Tail], [[Count, Head] | Es]) :- 
    encode(Tail, [[PrevCount, Head] | E]),
    Count is PrevCount + 1.
encode([Head|Tail], [[1, Head], [Count, X] | E]) :-
    encode(Tail, [[Count, X] | E]),
    Head \= X.


% P11 - Modified run-length encoding

encode_modified(L1, L2) :-
    encode(L1, L),
    modify(L, L2).

modify([], []).
modify([[1, X]|T], [X|Y]) :- modify(T, Y).
modify([[N, X]|T], [[N, X]|Y]) :- 
    N > 1,
    modify(T, Y).


% P12 - Decode a run-length encoded list 

generate(0, _, []) :- !.
generate(N, X, [X|T]) :-
    N > 0,
    Nprev is N - 1,
    generate(Nprev, X, T).

decode([], []).
decode([[N, X]|T], R) :-
    generate(N, X, L),
    decode(T, TD),
    append(L, TD, R).
decode([X|T], [X|TD]) :-
    X \= [_, _],
    decode(T, TD).


% P13 - Run-length encoding of a list (direct solution)


% P14 - Duplicate elements of a list

dupli(_, 0, []).
dupli([], _, []).
dupli([H|T], N, L) :-
    N >= 1,
    generate(N, H, L1),
    dupli(T, N, L2),
    append(L1, L2, L).
