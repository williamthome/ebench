-module(ebench).

-export([run/1, run/2, priv_dir/0]).

run(MFAs) ->
    run(MFAs, #{}).

run(MFAs, Opts) ->
    % The avg is average iterations per second.
    % Higher is best.
    Bench = lists:map(fun({M, F, A}) -> #{runner => {M, F, A}} end, MFAs),
    BenchOpts = #{
        report => maps:get(report, Opts, basic),
        samples => maps:get(samples, Opts, 3)
    },
    erlperf:benchmark(Bench, BenchOpts, undefined).

priv_dir() ->
    code:priv_dir(?MODULE).
