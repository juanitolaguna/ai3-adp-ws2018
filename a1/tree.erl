
%%===============================================%%
% Alternative Tree implementierung mit Key Value
%%===============================================%%


-module(tree).
-export([empty/0, insert/3, lookup/2]).

% {node {K, V, Smaller, Larger}}

empty() -> {node, 'nil'}.


insert(Key, Val, N = {node, 'nil'}) ->
	{node, {Key, Val, N, N}};

insert(NewKey, NewVal, {node, {Key, Val, Smaller, Bigger}}) when NewKey < Key ->
	{node, Key, Val, insert(NewKey, NewVal, Smaller), Bigger};

insert(NewKey, NewVal, {node, {Key, Val, Smaller, Bigger}}) when NewKey > Key ->
	{node, Key, Val, Smaller, insert(NewKey, NewVal, Bigger)};
	
insert(Key, Val, {node, {Key, _, Smaller, Bigger}}) ->
{node, {Key, Val, Smaller, Bigger}}.



lookup(_, {node, 'nil'}) -> undefined;
lookup(Key, {node, {Key, Value, _, _}}) -> Value;
lookup(Key, {node, {NodeKey,_, Smaller, _}}) when Key < NodeKey ->
	lookup(Key, Smaller);
lookup(Key, {node, NodeKey, _, _, Bigger}) when Key >= NodeKey -> 
	lookup(Key, Bigger).

