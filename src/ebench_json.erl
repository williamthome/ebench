-module(ebench_json).

-export([run/0, run/1, get_json/1]).

run() ->
    % 8.1 MB JSON file
    run(get_json("issue-90.json")).

run(Filename) ->
    {ok, Bin} = file:read_file(Filename),
    % The avg is average iterations per second.
    % Higher is best.
    ebench:run([
        {thoas, decode, [Bin]},    % avg: 10
        {jsx, decode, [Bin]},      % avg: 7
        {jiffy, decode, [Bin]},    % avg: 46
        {jsone, decode, [Bin]},    % avg: 14
        {jsxrecord, decode, [Bin]} % avg: 7
    ], #{samples => 20}).

get_json(Filename) ->
    filename:join([ebench:priv_dir(), "json", Filename]).
