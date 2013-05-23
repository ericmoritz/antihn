%%% @author Eric Moritz <eric@themoritzfamily.com>
%%% @copyright (C) 2013, Eric Moritz
%%% @doc
%%%
%%% @end
%%% Created : 22 May 2013 by Eric Moritz <eric@themoritzfamily.com>

-module(antihn_handler).


-export([
	 init/3,
	 handle/2,
	 terminate/3
]).

%%--------------------------------------------------------------------
%% Cowboy Handler Callbacks
%%--------------------------------------------------------------------
init(_Transport, Req, []) ->
    {ok, Req, undefined}.

handle(Req, State) ->
    {ok, Redirects} = redirects(),
    N = random:uniform(size(Redirects)),
    Choice = erlang:element(N, Redirects),
    {ok, Req2} = cowboy_req:reply(
		   302,
		   [
		    {<<"location">>, Choice}
		   ],
		   <<"HNDD is bad mmmkay.\n">>,
		   Req
		  ),
    {ok, Req2, State}.

terminate(_Reason, _Req, _State) ->
    ok.

%%--------------------------------------------------------------------
%% Internal
%%--------------------------------------------------------------------
-spec redirects() -> {ok, tuple()}.
redirects() ->
    application:get_env(antihn, redirects).
