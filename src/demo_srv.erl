-module(demo_srv).

-include("demo.hrl").

-define(INTERVAL, 2000).

%% ------------------------------------------------
%% API Function Exports
%% ------------------------------------------------

-export([start_link/0]).

%% ------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------

start_link() ->
    {ok, spawn_link(fun loop/0)}.

%% ------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------

loop() ->
    loop(1).

loop(Count) ->
    timer:sleep(?INTERVAL),
    announce(Count),
    loop(Count + 1).

announce(Count) ->
    ?INFO_MSG(
        "demo doing its ~p. loop.~n",
        [Count]).
