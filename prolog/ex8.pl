:- module(ex8,
       [ tree/1,
         contains/2,
         preorder/2]).

tree(empty).
tree(X) :- atom(X).
tree(X, tree(L), tree(R)) :- atom(X).

% contains(X, Elem)
%contains(tree(Elem), Elem) :- atom(Elem).
%contains(tree(_, Ltree), Elem) :- contains(Ltree, Elem).
%contains(tree(_,Ltree, _) ,Elem) :- contains(Ltree, Elem).
%contains(tree(_, _, Rtree),Elem) :- contains(Rtree, Elem).

contains(tree(Elem, _, _), Elem).
contains(tree(_, Ltree, _), Elem) :- contains(Ltree, Elem).
contains(tree(_, _, Rtree), Elem) :- contains(Rtree, Elem).


%null in prolog? - empty for tree?
% preorder(X, List)
%preorder(tree(X, Ltree, Rtree), List) :- append(X, List, NewList),
%preorder(Ltree, NewList),
%preorder(Rtree, NewList).


preorder(tree(empty), []). %base case, empty list
%preorder(tree(X), List) :- atom(X) 
preorder(tree(X, Ltree, Rtree), List) :-
preorder(Ltree, Leftreturn),
preorder(Rtree, Rightreturn),
%append(Leftreturn, Rightreturn, NewList)
append([X], Leftreturn, First),
append(First, Rightreturn, List).

%preorder(tree(f, tree(b, tree(a, tree(empty), tree(empty)), tree(d, tree(c, tree(empty), tree(empty)), tree(e, tree(empty), tree(empty)))), tree(g, tree(empty), tree(i, tree(h, tree(empty), tree(empty)), tree(empty)))), X).