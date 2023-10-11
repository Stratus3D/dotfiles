% TODO: Update this module so custom functions are added
-module(user_default).

% Help function
-export([help/0]).

% General
-export([l/0, mm/0, la/0, write_term/2]).

% OS
-export([cmd/1, debug_binary/1]).

% Tracing
-export([my_tracer/0, my_dhandler/2, filt_state_from_term/1]).
-export([trace_to_group_leader/0,dbgtc/1, dbgon/1, dbgon/2,
         dbgadd/1, dbgadd/2, dbgdel/1, dbgdel/2, dbgallp/0, dbgoff/0, dbgend/0,
         dbg_ip_trace/1]).

% Debugging
-export([environment/0]).

% For telemetry events
-export([telemetry_attach_all/0, telemetry_attach_all/1, telemetry_stop/0]).

-import(io, [format/1, format/2]).

% TODO: Don't hardcode all this info here
% {Command, Help, Usage},
-define(HELP, [
                % Modules
                {"l()", "load all changed modules", undefined},
                {"la()", "load all modules", undefined},
                %     format("nl()          -- load all changed modules on all known nodes\n"),
                {"mm()", "list modified modules", undefined},
                % Tracing
                {trace_to_group_leader, "Start a dbg trace and print traces to group leader", undefined},
                {"dbgtc(File)", "use dbg:trace_client() to read data from File", undefined},
                {"dbgon(M)", "enable dbg tracer on all funs in module M", undefined},
                {"dbgon(M,Fun)", "enable dbg tracer for module M and function F", undefined},
                {"dbgon(M,File)", "enable dbg tracer for module M and log to File", undefined},
                {"dbgadd(M)", "enable call tracer for module M", undefined},
                {"dbgadd(M,F)", "enable call tracer for function M:F", undefined},
                {"dbgdel(M)", "disable call tracer for module M", undefined},
                {"dbgdel(M,F)", "disable call tracer for function M:F", undefined},
                {"dbgallp()", "trace on all processes", undefined},
                {"dbgoff()","disable dbg tracer (calls dbg:stop/0)", undefined},
                {"dbgend()","disable dbg tracer and clear traces (calls dbg:stop_clear/0)", undefined},
                % OS
                {"cmd(Command)", "Execute Command in the shell of the OS and print the result", undefined},
                {"cmd(Command)", "Prints a binary as a sequence of ones and zeros", undefined}
               ]).

help() ->
    shell_default:help(),
    format("** user extended commands **~n~n"),
    [command_help(Command, Help, Usage) || {Command, Help, Usage} <- ?HELP],
     true.

command_help(Command, Help, undefined) ->
    format("~-30s -- ~s~n", [Command, Help]);
command_help(Command, Help, Usage) ->
    format("~-30s -- ~s. Usage: ~p~n", [Command, Help, Usage]).

%%%===================================================================
%%% General
%%%===================================================================

write_term(Path, Term) ->
    file:write_file(Path, io_lib:fwrite("~p.~n", [Term])).

trace_to_group_leader() ->
    dbg:tracer(process, {fun(Msg, _) -> io:format("~p\n", [Msg]) end, []}).

dbgtc(File) ->
    Fun = fun({trace,_,call,{M,F,A}}, _) ->
                 io:format("call: ~w:~w~w~n", [M,F,A]);
             ({trace,_,return_from,{M,F,A},R}, _) ->
                 io:format("retn: ~w:~w/~w -> ~w~n", [M,F,A,R]);
             (A,B) ->
                 io:format("~w: ~w~n", [A,B])
          end,
    dbg:trace_client(file, File, {Fun, []}).

dbgallp() ->
    dbg:p(all, c).

dbgon(Module) ->
    case dbg:tracer() of
    {ok,_} ->
       dbg:p(all,call),
       dbg:tpl(Module, [{'_',[],[{return_trace}]}]),
       ok;
    Else ->
       Else
    end.

dbgon(Module, Fun) when is_atom(Fun) ->
    {ok,_} = dbg:tracer(),
    dbg:p(all,call),
    %%dbg:tpl(Module, Fun, [{'_',[],[{return_trace}]}]),
    dbg:tpl(Module, Fun, [{'_',[],[{return_trace},{exception_trace}]}]),
    ok;

dbgon(Module, File) when is_list(File) ->
    {ok,_} = dbg:tracer(port, dbg:trace_port(file, File)),
    dbg:p(all,[call, running, garbage_collection, timestamp, return_to]),
    %%dbg:tpl(Module, [{'_',[],[{return_trace}]}]),
    dbg:tpl(Module, [{'_',[],[{return_trace},{exception_trace}]}]),
    ok;

dbgon(Module, TcpPort) when is_integer(TcpPort) ->
    io:format("Use this command on the node you're tracing (-remsh ...)\n"),
    io:format("Use dbg:stop() on target node when done.\n"),
    {ok,_} = dbg:tracer(port, dbg:trace_port(ip, TcpPort)),
    dbg:p(all,call),
    %%dbg:tpl(Module, [{'_',[],[{return_trace}]}]),
    dbg:tpl(Module, [{'_',[],[{return_trace},{exception_trace}]}]),
    ok.

dbg_ip_trace(TcpPort) ->
    io:format("Run on same machine as target but NOT -remsh target-node\n"),
    io:format("Use dbg:stop() when done.\n"),
    dbg:trace_client(ip, TcpPort).

dbgadd(Module) ->
    %%dbg:tpl(Module, [{'_',[],[{return_trace}]}]),
    dbg:tpl(Module, [{'_',[],[{return_trace},{exception_trace}]}]),
    ok.

dbgadd(Module, Fun) ->
    %%dbg:tpl(Module, Fun, [{'_',[],[{return_trace}]}]),
    dbg:tpl(Module, Fun, [{'_',[],[{return_trace},{exception_trace}]}]),
    ok.

dbgdel(Module) ->
    dbg:ctpl(Module),
    ok.

dbgdel(Module, Fun) ->
    dbg:ctpl(Module, Fun),
    ok.

dbgoff() ->
    dbg:stop().

dbgend() ->
    dbg:stop_clear().

%% Reload modules that have been modified since last load.  From Tobbe
%% Tornqvist, http://blog.tornkvist.org/, "Easy load of recompiled
%% code", which may in turn have come from Serge?

l() ->
    [c:l(M) || M <- mm()].

mm() ->
    modified_modules().

modified_modules() ->
    [M || {M, _} <- code:all_loaded(),
	  module_modified(M) == true].

module_modified(Module) ->
    case code:is_loaded(Module) of
	{file, preloaded} ->
	    false;
	{file, Path} ->
	    CompileOpts =
		proplists:get_value(compile, Module:module_info()),
	    CompileTime = proplists:get_value(time, CompileOpts),
	    Src = proplists:get_value(source, CompileOpts),
	    module_modified(Path, CompileTime, Src);
	_ ->
	    false
    end.

module_modified(Path, PrevCompileTime, PrevSrc) ->
    case find_module_file(Path) of
	false ->
	    false;
	ModPath ->
	    case beam_lib:chunks(ModPath, ["CInf"]) of
		{ok, {_, [{_, CB}]}} ->
		    CompileOpts =  binary_to_term(CB),
		    CompileTime = proplists:get_value(time,
						      CompileOpts),
		    Src = proplists:get_value(source, CompileOpts),
		    not (CompileTime == PrevCompileTime) and
							   (Src == PrevSrc);
		_ ->
		    false
	    end
    end.

find_module_file(Path) ->
    case file:read_file_info(Path) of
	{ok, _} ->
	    Path;
	_ ->
	    %% may be the path was changed
	    case code:where_is_file(filename:basename(Path)) of
		non_existing ->
		    false;
		NewPath ->
		    NewPath
	    end
    end.

%% Reload all modules, regardless of age.
la() ->
    FiltZip = lists:filter(
	fun({_Mod, Path}) when is_list(Path) ->
		case string:str(Path, "/kernel-") +
		     string:str(Path, "/stdlib-") of
			0 -> true;
			_ -> false
		end;
	    (_) -> false
	end, code:all_loaded()),
    {Ms, _} = lists:unzip(FiltZip),
    lists:foldl(fun(M, Acc) ->
			case shell_default:l(M) of
				{error, _} -> Acc;
				_          -> [M|Acc]
			end
		end, [], Ms).

my_tracer() ->
    dbg:tracer(process, {fun my_dhandler/2, user}).

my_dhandler(TraceMsg, Acc) ->
    dbg:dhandler(filt_state_from_term(TraceMsg), Acc).

filt_state_from_term(T) when is_tuple(T), element(1, T) == state ->
    sTatE;
filt_state_from_term(T) when is_tuple(T), element(1, T) == chain_r ->
    cHain_R;
filt_state_from_term(T) when is_tuple(T), element(1, T) == g_hash_r ->
    g_Hash_R;
filt_state_from_term(T) when is_tuple(T), element(1, T) == hash_r ->
    hAsh_R;
filt_state_from_term(T) when is_tuple(T) ->
    list_to_tuple(filt_state_from_term(tuple_to_list(T)));
filt_state_from_term([H|T]) ->
    [filt_state_from_term(H)|filt_state_from_term(T)];
filt_state_from_term(X) ->
    X.

cmd(Command) ->
    io:format("~s~n", [os:cmd(Command)]).

debug_binary(Bin) ->
    io:format("Binary: ~s~n", [[ <<(X+$0)>> || <<X:1>> <= Bin]]).

%%%===================================================================
%%% Debugging
%%%===================================================================

environment() ->
    Apps = application:which_applications(),
    AppNames = [AppName || {AppName, _Desc, _Version} <- Apps],
    [{App, application:get_all_env(App)} || App <- AppNames].

%%%===================================================================
%%% Telemetry Events
%%%===================================================================

% telemetry_attach_all/0 prints out all telemetry events received
telemetry_attach_all() ->
  telemetry_attach_all(fun(Name, MetaOrMeasure, MetaOrFun) ->
      % Print out telemetry info
      io:format("Telemetry event: ~w~nwith ~p and ~p~n", [Name, MetaOrMeasure, MetaOrFun])
    end).

% telemetry_attach_all/1 allows you to specify a handler function that
% will be invoked with the same three arguments that the
% `telemetry:execute/3` and `telemetry:span/3` functions were invoked
% with.
telemetry_attach_all(Function) ->
  % Start the tracer
  dbg:start(),

  % Create tracer process with a function that pattern matches out the three
  % arguments the telemetry calls are made with.
  dbg:tracer(process, {fun({_, _, _, {_Mod, _Fun, [Name, MetaOrMeasure, MetaOrFun]}}, _State) ->
      Function(Name, MetaOrMeasure, MetaOrFun)
    end, undefined}),

  % Trace all processes
  dbg:p(all, c),

  % See all emitted telemetry events
  dbg:tp(telemetry, execute, 3, []),
  dbg:tp(telemetry, span, 3, []).

telemetry_stop() ->
  dbg:stop_clear().
