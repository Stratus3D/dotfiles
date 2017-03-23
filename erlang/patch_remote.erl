% @doc
% Enable patching of modules on remote nodes. Currently only works with short
% names.
% @end

-module(patch_remote).

-export([with_module/2, with_module/4]).

% @doc Convience function for remsh's

with_module(ModuleName, InitArgs) ->
    [Remsh] = proplists:get_value(remsh, InitArgs),
    [CookieList] = proplists:get_value(setcookie, InitArgs),
    [SnameList] = proplists:get_value(sname, InitArgs),
    with_module(ModuleName, list_to_atom(Remsh), list_to_atom(CookieList), list_to_atom(SnameList)).

% @doc Take a module name, get the code for it, and then load it on the remote
% host

with_module(ModuleName, Remote, CookieList, SnameList) ->
    % Set the cookie and node name of the current node so we can rpc into the
    % remote node
    net_kernel:start([SnameList, shortnames]),
    erlang:set_cookie(node(), CookieList),
    Node = Remote,

    % Get the code for the module
    {Module, Binary, _} = code:get_object_code(ModuleName),

    rpc:call(Node, code, purge, [Module]),
    Return = case rpc:call(Node, code, which, [Module]) of
                 [] ->
                     % Load it into the remote node
                     rpc:call(Node, code, load_binary, [Module, [], Binary]);
                 non_existing ->
                     % Load it into the remote node
                     rpc:call(Node, code, load_binary, [Module, [], Binary]);
                 Filename when is_binary(Filename) orelse is_list(Filename) ->
                     io:format("Filename: ~p~n", [Filename]),
                     ok = rpc:call(Node, file, write_file, [Filename, Binary]),
                     rpc:call(Node, code, load_file, [Module])
             end,

    case Return of
        {module, Module} ->
            ok;
        {error, Reason} ->
            % Failed
            Reason
    end.

%with_module(ModuleName, Remote, CookieList, SnameList) ->
%    % Set the cookie and node name of the current node so we can rpc into the
%    % remote node
%    net_kernel:start([SnameList, shortnames]),
%    erlang:set_cookie(node(), CookieList),
%    Node = Remote,
%
%    % Get the code for the module
%    {Module, Binary, _} = code:get_object_code(ModuleName),
%
%    Return = case rpc:call(Node, code, which, [Module]) of
%                 Filename when is_binary(Filename) orelse is_list(Filename) ->
%                     ok = rpc:call(Node, file, write_file, [Filename, Binary]),
%                     rpc:call(Node, code, purge, [Module]),
%                     rpc:call(Node, code, load_file, [Module]);
%                 _ ->
%                     % Load it into the remote node
%                     rpc:call(Node, code, load_binary, [Module, [], Binary])
%             end,
%
%    case Return of
%        {module, Module} ->
%            ok;
%        {error, Reason} ->
%            % Failed
%            Reason
%    end.
