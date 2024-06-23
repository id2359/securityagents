// Agent sample_agent in project security_agents

/* Initial beliefs and rules */

camera(ok).
enabled(true).

/* Initial goals */


/* Plans */

+!start : true
    <- .print("watcher started!");
       .date(Y,M,D); .time(H,Min,Sec,MilSec); // get current date & time
       +started(Y,M,D,H,Min,Sec);
       ?camera(State);
       ?id(Id);
       .send(controller, tell, camera(Id,ok)).


+!take_picture : enabled(true)
    <- .print("taking picture!");
       .send(controller, tell, front(person)).

+!shutdown: enabled(true)
    <- .print("shutting down!");
       .update(enabled,false).


{ include("$jacamo/templates/common-cartago.asl") }
{ include("$jacamo/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moise/asl/org-obedient.asl") }
