-module(main).
-export([manager/0, customer/1]).

customer({DishName, TimeToCook}, Cid) -> %Cid = Pid of a chef process
   Cid ! {DishName, TimeToCook};
customer({}) ->
   {};
customer(_) ->
   io:format("~s~p", "Wrong Format").

chef() ->
   receive
      _ -> io:format("~s~n", "Recieved Data")
   end.

manager() ->
   io:format("~s~n", "Starting..."),
   Cid = spawn(main, chef, []),
   spawn(main, customer, [{Pasta, 500}, Cid]).
