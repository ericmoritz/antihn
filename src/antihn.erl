%%% @author Eric Moritz <eric@themoritzfamily.com>
%%% @copyright (C) 2013, Eric Moritz
%%% @doc
%%% 
%%% @end
%%% Created : 22 May 2013 by Eric Moritz <eric@eric-acer>

-module(antihn).


-export([
	 start/0
]).

start() ->
    apptools:ensure_started(antihn, permanent).
