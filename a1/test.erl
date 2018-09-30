%%===============================================%%
% Sämtliche Funktionen zum Verständniss u. Testen
%%===============================================%%


-module(test).


-export([fac/1, convert/2, convert_length/1, main/0, beach/1, len/1, 
	duplicate/2, dupEach/2, tail_duplicate/2, reverse/1, tail_reverse/1, 
	sublist/2, tail_sublist/2, zip/2, tail_zip/2, quicksort/1, partition/4, 
	lc_quicksort/1, append/2, while/1]).


fac(1) -> 1;
fac(N) -> N * fac(N-1).


convert(M, inch) ->
    M / 2.54;

convert(N, centimeter) ->
    N * 2.54.

convert_length({centimeter, X}) ->
	{inch, X / 2.54};
convert_length({inch, Y}) ->
	{centimeter, Y * 2.54}.


% guards
beach(Temperature) ->
    case Temperature of
        {celsius, N} when N >= 20, N =< 45 ->
            'favorable';
        {kelvin, N} when N >= 293, N =< 318 ->
            'scientifically favorable';
        {fahrenheit, N} when N >= 68, N =< 113 ->
            'favorable in the US';
        _ -> 'avoid beach'
    end. 
main() ->ok.


% length of array
% len([]) -> 0;
% len([_|T]) -> 1 + len(T).

len(L) -> len(L, 1).
len([], Acc) -> Acc;
len([_|T], Acc) -> len(T, Acc + 1).


% duplicate(Term, Acc) when Acc =:= 0 -> 0;
% duplicate([Term|_], Acc) -> 1 + duplicate(Term ,Acc-1).


% N - Times 
% Term - digit to duplicate

duplicate(0, _) -> [];
duplicate(N, Term) when N > 0 -> [Term| duplicate(N-1, Term)].


tail_duplicate(N, Term) -> tail_duplicate(N, Term, []).
tail_duplicate(0,_, List) -> List;
tail_duplicate(N, Term, List) when N > 0 -> 
		tail_duplicate(N-1, Term, [Term|List]).



% dupEach(N, List) -> [duplicate(N, X)|| X <- List].
dupEach(_,[]) -> [];
dupEach(N, [T|Tail]) -> duplicate(N, T) ++ dupEach(N,Tail).


reverse([]) -> [];
reverse([H|T]) ->
	reverse(T) ++ [H].


tail_reverse(L) -> tail_reverse(L, []).
tail_reverse([], List) -> List;
tail_reverse([H|T], List) -> tail_reverse(T, [H|List]).



sublist(_L, 0) -> [];
sublist([H|T], N) when N > 0 ->
	[H|sublist(T, N-1)].


tail_sublist(List, N) -> tail_sublist(List, N, []).

tail_sublist(_List, 0, SubList) -> SubList;
tail_sublist([H|T], N, SubList) ->
	tail_sublist(T, N-1, SubList ++ [H]).


%% Alternative Solution:

% tail_sublist(List, N) -> lists:reverse(tail_sublist(List, N, [])).
% tail_sublist(_List, 0, SubList) -> SubList;
% tail_sublist([H|T], N, SubList) ->
% 	tail_sublist(T, N-1, [H|SubList]).


% test:zip([a,b,c],[1,2,3]).
% [{a,1},{b,2},{c,3}]

zip([],[]) -> [];
zip([H|T], [H1|T1]) ->
	[{H,H1}|zip(T,T1)].

tail_zip(L1, L2) -> lists:reverse(tail_zip(L1,L2,[])).

tail_zip([], _, L3) -> L3;
tail_zip(_, [], L3) -> L3;
tail_zip([H|T], [H1|T1], L3) ->
	tail_zip(T, T1, [{H, H1}|L3]).


% quicksort([]) -> [];
% quicksort([Pivot|Rest]) ->
% 	{Smaller, Bigger} = lists:partition(fun(A) -> A >= Pivot end, Rest),
% 	quicksort(Smaller) ++ [Pivot] ++ quicksort(Bigger).



quicksort([]) -> [];
quicksort([Pivot|Rest]) ->
	{Smaller, Bigger} = partition(Pivot, Rest, [], []),
	quicksort(Smaller) ++ [Pivot] ++ quicksort(Bigger).


%% custom implementation of partition.
partition(_, [], Smaller, Bigger) -> {Smaller, Bigger};
partition(Pivot, [H|T], Smaller, Bigger) -> 
	if H =< Pivot -> partition(Pivot, T, [H|Smaller], Bigger);
		H > Pivot -> partition(Pivot, T, Smaller, [H|Bigger])
	end.

lc_quicksort([]) -> [];
lc_quicksort([Pivot|Rest]) ->
	lc_quicksort([Smaller || Smaller <- Rest, Smaller =< Pivot])
	++ [Pivot]
	++ lc_quicksort([Bigger || Bigger <- Rest, Bigger > Pivot]).


append([H|T], Tail) ->
	[H|append(T, Tail)];
append([], Tail) -> Tail.


while(L) -> while(L,0).
while([], Acc) -> Acc;

while([_|T], Acc) ->
	io:fwrite("HelloWorld\n", [Acc]),
	while(T, Acc+1).

















    
    
    

