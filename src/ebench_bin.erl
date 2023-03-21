-module(ebench_bin).

-export([run/0]).

run() ->
    Filename = ebench_json:get_json("issue-90.json"),
    {ok, Bin} = file:read_file(Filename),
    ebench:run([
        {erlang, iolist_to_binary, [Bin]},          % 23_151_693 !!
        {unicode, characters_to_binary, [Bin]},     % 155
        {unicode, characters_to_nfc_binary, [Bin]}, % 0
        {unicode, characters_to_list, [Bin]}        % 1
    ]).
