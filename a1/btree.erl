-module(btree).

-export([initBT/0, isEmptyBT/1, equalBT/2, insertBT/2, deleteBT/2, findBT/2, inOrderBT/1, 
	tree1/0, tree2/0, tree3/0, tree4/0, uniteBT/2]).

-define(EMPTY, {}).

%% tree - T
%% elem - E (num)
%% height - H
%% L - Left (smaller)
%% R - Bigger (bigger)

%% Der Baum nimmt nur zahlen wahr, 
%% Zweites Element zeigt die höhe an.


% Initialisiert einen leeren Baum.
initBT() -> ?EMPTY.

% Gibt zurück ob ein Baum T leer ist.
isEmptyBT(T) -> T == ?EMPTY.


% Fügt einem Baum T ein Element E hinzu. Setzt die Höhe.
insertBT(E, N) -> insertBT(E, 0, N).

insertBT(E, H, {}) -> {E, H+1, initBT(), initBT()};

insertBT(NewElem, _, {E, H, L, R}) -> 
	if E < NewElem -> {E, H, insertBT(NewElem, H, L), R};
		E > NewElem -> {E, H, L, insertBT(NewElem, H, R)};
		E == NewElem -> {E, H, L, R}
	end.


% Gibt den Baum als geordnete Liste zurück.
% Nutzt die Hilfsfunktion inOrderBT/2.
inOrderBT({}) ->inOrderBT(nil, []);
inOrderBT(T) -> lists:reverse(inOrderBT(T, [])).

inOrderBT(nil, A) -> A;
inOrderBT({}, A) -> A;
inOrderBT({ C, _H, L, R}, A) -> inOrderBT(L, [ C | inOrderBT(R, A)]).



%%===============================================%%
%	Ab hier Korigieren bzw. verfolständigen.
%%===============================================%%

%%Wirft einen fehler anstatt false.
%%Wenn true dann true.
equalBT({}, {}) -> true; 
equalBT({E1, _, L1, R1}, {E2, _, L2, R2}) ->
	if E1 == E2 -> 
		equalBT(L1, L2),
		equalBT(R1, R2)
	end.




% Gibt die Höhe des gesuchten Elements aus.
% Gibt es das Element nicht, gibt dies 0 zurück.
findBT({}, _E) -> 0;
findBT({ C, H, L, R }, E) ->
  if
    E > C -> findBT(R, E);
    E < C -> findBT(L, E);
    E == C -> H
  end.



% Entfernt ein Element E von einem Baum T.
% Nimmt an, dass das Element existent ist.
% Funktioniert nicht wegen uniteBT.


 deleteBT(Key, {Key1, H, L, R}) when Key < Key1 ->
    {Key1, H, deleteBT(Key, L), R};	
 deleteBT(Key, {Key1, H, L, R}) when Key > Key1 -> 
  	{Key1, H, L, deleteBT(Key, R)};
 deleteBT(_, {_,_, L, R}) ->  %%L ++ R 
 	uniteBT(L,R).


%% Hilfsfunktion - Vereint zwei Bäume miteinander.
%% Nicht fertig, unite funktioniert nicht richtig.

 uniteBT(L, nil) -> L;
 uniteBT(nil, R) -> R;
 uniteBT({E1, _, L, _}, T2) ->
 	uniteBT(L, insertBT(E1, T2)).

 % insertBT(E1, T2),
 % uniteBT(L, T2),
 % uniteBT(R, T2).




%%===============================================%%
%					Zum testen.
%%===============================================%%
tree1() -> {3,1,{4,2,{7,3,{17,4,{},{}},{}},{}},{2,2,{},{1,3,{},{}}}}.
tree2() -> {3,1,{4,2,{7,3,{14,4,{},{}},{}},{}},{2,2,{},{1,3,{},{}}}}.
tree3() -> {3,1,{5,2,{6,3,{},{}},{}},{2,2,{},{1,3,{},{}}}}.
tree4() -> {3,1,{4,2,{7,3,{},{}},{}},{2,2,{},{1,3,{},{}}}}.


% c(btree).
% Tree = btree:initBT().
% Tree2 = btree:insertBT(3, Tree).
% Tree3 = btree:insertBT(2, Tree2).
% Tree4 = btree:insertBT(4, Tree3).
% Tree5 = btree:insertBT(1, Tree4).
% Tree6 = btree:insertBT(7, Tree5).
% Tree7 = btree:insertBT(17, Tree6).


