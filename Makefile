
all: get-deps build

get-deps:
	rebar get-deps

build:
	rebar compile

shell:
	PORT=8000 erl -pa ebin/ deps/*/ebin -s antihn
