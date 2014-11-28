-module(demo_srv).
-behaviour(gen_server).
-include("demo.hrl").

-define(INTERVAL, 2000).
-define(SERVER, ?MODULE).

-record(state, {count, last_ping}).

%% ------------------------------------------------
%% API Function Exports
%% ------------------------------------------------

-export([start_link/0]).

%% ------------------------------------------------
%% gen_server Function Exports
%% ------------------------------------------------

-export([init/1, handle_call/3, handle_cast/2,
         handle_info/2, terminate/2,
         code_change/3]).

%% ------------------------------------------------
%% API Function Definitions
%% ------------------------------------------------

start_link() ->
    gen_server:start_link({local, ?SERVER},
        ?MODULE, [], []).

%% ------------------------------------------------
%% gen_server Function Definitions
%% ------------------------------------------------

init([]) ->
    {ok, _TRef} =
        timer:send_interval(?INTERVAL, ping),
    {ok, #state{count = 1}}.

handle_info(ping, #state{count = Count,
                         last_ping = Ts} = State) ->
    announce(Count, Ts),
    {noreply, State#state{count = Count + 1,
                          last_ping = now()}};
handle_info(_Info, #state{} = State) ->
    {noreply, State}.

handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

terminate(_Reason, _State) ->
    ok.

code_change(OldVsn, State, Extra) ->
    ?INFO_MSG("CODE CHANGED in ~p~n"
              "  OldVsn: ~p~n"
              "  State: ~p~n"
              "  Extra: ~p~n",
              [?MODULE,
               OldVsn, State, Extra]),
    {ok, upgrade_state(State)}.

%% ------------------------------------------------
%% Internal Function Definitions
%% ------------------------------------------------

announce(Count, Ts) ->
    ?INFO_MSG(
        "demo doing its ~p. loop.~n"
        "last_ping ~p~n",
        [Count, Ts]).

upgrade_state({state, Count}) ->
    {state, Count, now()};
upgrade_state(State) ->
    State.
