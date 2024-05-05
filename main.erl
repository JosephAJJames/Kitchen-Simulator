-module(main).
-export([manager/1, customer/2, chef/0, custIter/2]).

customer({DishName, TimeToCook}, Cid) -> %Cid = Pid of a chef process
   Cid ! {DishName, TimeToCook};
customer({}, _) ->
   {};
customer(_, _) ->
   io:format("~s~n", ["Wrong Format"]).

chef() ->
   receive
      {DishName, TimeToCook} -> io:format("Received Order: ~p~n", [DishName]),
      chef()
   end.

custIter([Head | Tail] ,Cid) ->
   spawn(main, customer, [Head, Cid]),
   custIter(Tail, Cid);
custIter([], Cid) ->
   Cid.

manager(List) ->
   io:format("~s~n", ["Starting..."]),
   Cid = spawn(main, chef, []),
   custIter(List, Cid).
