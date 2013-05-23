
-module(antihn_sup).

-behaviour(supervisor).

%% API
-export([start_link/1, dispatch/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link(Port) ->
    R = supervisor:start_link({local, ?MODULE}, ?MODULE, [Port]),
    error_logger:info_msg("Listening on port ~w~n", [Port]),
    R.

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================
dispatch() ->
    [
     {'_', [
	    {"/", antihn_handler, []}
	   ]
     }
    ].



init([Port]) ->
    Dispatch = cowboy_router:compile(dispatch()),
    CowboySpec = ranch:child_spec(antihn,
		   100,
		   ranch_tcp, [{port, Port}],
		   cowboy_protocol, [{env, [{dispatch, Dispatch}]}]
		  ),

    {ok, { {one_for_one, 5, 10}, [CowboySpec]} }.

