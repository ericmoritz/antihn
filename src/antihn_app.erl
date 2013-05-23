-module(antihn_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->
    antihn_sup:start_link(port()).

stop(_State) ->
    ok.


port() ->
    port(os:getenv("PORT")).

port(false) ->
    8000;
port(PortStr) ->
    list_to_integer(PortStr).

