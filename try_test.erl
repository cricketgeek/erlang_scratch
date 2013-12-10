-module(try_test).

-compile(export_all).

generate_exception(1) -> a;
generate_exception(2) -> throw(a);
generate_exception(3) -> exit(a);
generate_exception(4) -> {'Exit',a};
generate_exception(5) -> error(a).

demo1() ->
    [catcher(I) || I <- [1,2,3,4,5]].

catcher(N) ->
    try generate_exception(N) of
        Val -> {N, normal, Val}
    catch
        throw:X -> {N, caught, thrown, X};
        exit:X  -> {N, caught, exited, X};
        error:X -> {N, caught, error, X, erlang:get_stacktrace()}
    end.

demo2() -> 
    [{I, (catch generate_exception(I))} || I <- [1,2,3,4,5]].

sqrt(X) when X < 0 ->
    error({squareRootNegativeArgument, X});
sqrt(X) ->
    math:sqrt(X).
