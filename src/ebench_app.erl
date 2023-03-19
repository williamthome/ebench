%%%-------------------------------------------------------------------
%% @doc ebench public API
%% @end
%%%-------------------------------------------------------------------

-module(ebench_app).

-behaviour(application).

-export([start/2, stop/1]).

start(_StartType, _StartArgs) ->
    ebench_sup:start_link().

stop(_State) ->
    ok.

%% internal functions
