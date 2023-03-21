-module(ebench_json).

-export([run/1, run/2, get_json/1]).

run(Action) ->
    % 8.1 MB JSON file
    run(Action, get_json("issue-90.json")).

% The result is average iterations per second.
% Higher is best.
run(decode, Filename) ->
    {ok, Bin} = file:read_file(Filename),
    ebench:run([
        {thoas, decode, [Bin]},    % result: 10,
        {jsx, decode, [Bin]},      % result:  7
        {jiffy, decode, [Bin]},    % result: 46
        {jsone, decode, [Bin]},    % result: 14
        {jsxrecord, decode, [Bin]} % result:  7
    ], #{samples => 3, report => basic});
run(encode, Filename) ->
    {ok, Bin} = file:read_file(Filename),
    ebench:run([
        {thoas, encode, [ begin {ok, JSON} = thoas:decode(Bin)
                                , JSON end ]},       % result: 10
        {jsx, encode, [jsx:decode(Bin)]},            % result:  6
        {jiffy, encode, [jiffy:decode(Bin)]},        % result: 30
        {jsone, encode, [jsone:decode(Bin)]},        % result: 13
        {jsxrecord, encode, [jsxrecord:decode(Bin)]} % result:  7
    ], #{samples => 3, report => basic}).

get_json(Filename) ->
    filename:join([ebench:priv_dir(), "json", Filename]).
