-module($basename).

%% @doc
%% This module is a Quickcheck eqc_statem test that attempts to model possible
%% behaviours within <your model description here>
%% such as:
%%  - List
%%  - Of
%%  - Behaviours

-ifdef(TEST).
-ifdef(EQC).

-export([test/0, test/1]).
-export([prop_correct/0]).

-include_lib("eqc/include/eqc.hrl").
-include_lib("eqc/include/eqc_statem.hrl").

-behaviour(eqc_statem).

-export([initial_state/0,
         command/1,
         next_state/3,
         precondition/2,
         postcondition/3]).

-export([create_thing/0,
         restart_thing/0,
         destroy_thing/0,
         status_update/1,
         reconcile_status/1]).

-define(NUM_TESTS, 200).
-define(QC_OUT(P),
        eqc:on_output(fun(Str, Args) -> io:format(user, Str, Args) end, P)).

-record(state,
        {
        }).

setup() -> ok.
cleanup() -> ok.

%% EQC Util functions
test() -> test(?NUM_TESTS).
test(N) ->
     true = eqc:quickcheck(eqc:num_tests(N, ?QC_OUT(?MODULE:prop_correct()))).

%% eqc_statem

initial_state() ->
    #state{}.

command(#state{}) ->
    oneof([
        {call, ?MODULE, create_thing, []},
        {call, ?MODULE, restart_thing, [id()]},
        {call, ?MODULE, update_thing, [id()]},
        {call, ?MODULE, destroy_thing, [id()]}]).

precondition(_State, {call, _, _, _}) ->
    true.

postcondition(_State, {call, _, _, _}, _Result) ->
    true.

next_state(State, _Value, {call, ?MODULE, create_thing, []}=Call) ->
    error({unhandled_next_state, Call});
next_state(State, _Value, {call, ?MODULE, restart_thing, []}=Call) ->
    error({unhandled_next_state, Call});
next_state(State, _Value, {call, ?MODULE, update_thing, [_]}=Call) ->
    error({unhandled_next_state, Call});
next_state(State, _Value, {call, ?MODULE, destroy_thing, []}=Call) ->
    error({unhandled_next_state, Call}).

%% /eqc_statem

%% generators

id() -> non_empty(list(oneof(lists:seq(32, 126)))).

%% /generators

%% API

create_thing() ->
    error(unimplemented).

restart_thing(_Id) ->
    error(unimplemented).

update_thing(_Id) ->
    error(unimplemented).

destroy_thing(_Id) ->
    error(unimplemented).

%% /API

% Lovingly ripped off from https://github.com/basho/yokozuna/blob/f8a1724f1b9f0297d7801d79a6dfd37d8b74a1f3/test/yz_index_hashtree_eqc.erl#L442
prop_correct() ->
    ?SETUP(fun() -> setup(), fun() -> cleanup() end end,
    ?FORALL(Cmds, commands(?MODULE, #state{}),
            aggregate(command_names(Cmds),
                      ?TRAPEXIT(begin
                                    {H, S, Res} = run_commands(?MODULE, Cmds),

                                    %% Some cleanup perhaps?
                                    %% Persist the known-good states?

                                    pretty_commands(?MODULE,
                                                    Cmds,
                                                    {H, S, Res},
                                                    Res == ok)
                                end)))).
-endif.
-endif.
