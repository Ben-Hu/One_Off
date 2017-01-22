:- module(ex7,
       [ sublist/2,
         with/3,
         shuffled/2,
		 shuffle/2,
		 choose/2]).

% sublist(S, L) : S is a sublist of list L.
% Assumes L is instantiated/ground (will be a concrete list).
sublist([],[]).%only the empty list is the sublist of empty
sublist([], _). %empty list is a sublist of all lists
sublist([X|XS], [X|YS]) :- sublist(XS, YS).
%sublist([X|XS], [_|YS]) :- sublist(X, YS), sublist(XS, YS).
sublist([X|XS], [_|YS]) :- sublist([X|XS], YS).

% with(L, E, LE) : LE is the the list L with E inserted somewhere.
% Assumes L and E are instantiated.

with(L, E, [E|L]).
with([L|LS], E, [L|LES]) :- with(LS, E, LES).


% shuffled(L, S) : S is list L in some order.
shuffled([],[]).
shuffled(L, L).
shuffled([X|XS], [Z|ZS]) :- with(XS, X, [Z|ZS]), shuffled(XS, ZS).

%shuffled([L|LS], [S|SS]) :- sublist([L], [S|SS]), shuffled(LS, [S|SS]).  %need to think of correct base cases
%shuffled([],_). %not what we want

choose([], []).
choose(List, Elt) :-
        length(List, Length),
        random(0, Length, Index),
        nth0(Index, List, Elt).

shuffle([], []).
shuffle(List, [Element|Rest]) :-
        choose(List, Element),
        delete(List, Element, NewList),
        shuffle(NewList, Rest).