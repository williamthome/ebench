-module(json_bench).

-export([run/0, run/1]).

run() ->
    % 8.1 MB JSON file
    run("/home/williamthome/Projects/erlang/json_bench/priv/issue-90.json").

run(Filename) ->
    {ok, Bin} = file:read_file(Filename),
    % The avg is average iterations per second.
    % Higher is best.
    erlperf:benchmark([
        #{runner => {thoas, decode, [Bin]}},    % avg: 10
        #{runner => {jsx, decode, [Bin]}},      % avg: 7
        #{runner => {jiffy, decode, [Bin]}},    % avg: 46
        #{runner => {jsone, decode, [Bin]}},    % avg: 14
        #{runner => {jsxrecord, decode, [Bin]}} % avg: 7
    ], #{report => basic, samples => 20}, undefined).
