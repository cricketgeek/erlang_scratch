-module(lib_misc).
-compile(export_all).

for(Max,Max, F) -> [F(Max)];
for(I, Max, F) -> [F(I)|for(I+1,Max,F)].

qsort([]) -> [];
qsort([Pivot | T]) ->
    qsort([X || X <- T, X < Pivot])
    ++ [Pivot] ++ 
    qsort([X || X <- T, X >= Pivot]).

pythag(N) ->
    [ {A,B,C} ||
        A <- lists:seq(1,N),
        B <- lists:seq(1,N),
        C <- lists:seq(1,N),
        A+B+C =< N,
        A*A+B*B =:= C*C
    ].

perms([]) -> [[]];
perms(L) -> [[H|T] || H <- L, T <- perms(L--[H])].

filter(P, [H|T]) ->
    case P(H) of
        true -> [H|filter(P,T)];
        false -> filter(P,T)
    end;
filter(P,[]) ->
    [].


odds_and_evens(L) ->
    odds_and_evens_acc(L, [], []).

odds_and_evens_acc([H|T], Odds, Evens) ->
    case (H rem 2) of
        1 -> odds_and_evens_acc(T, [H|Odds], Evens);
        0 -> odds_and_evens_acc(T, Odds, [H|Evens])
    end;

odds_and_evens_acc([], Odds, Evens) ->
    {Odds, Evens}.
