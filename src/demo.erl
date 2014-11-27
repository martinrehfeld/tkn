-module(demo).

%% API
-export([start/0]).

%% ================================================
%% API functions
%% ================================================

start() ->
    ok = application:start(demo, permanent).
