// Agent sample_agent in project security_agents

/* Initial beliefs and rules */

intruder(false).
front(nothing).
back(nothing).

state(normal).

/* Initial goals */

!start.

/* Plans */

+!start : true
    <- .print("controller started\n");
       .date(Y,M,D); .time(H,Min,Sec,MilSec); // get current date & time
       +started(Y,M,D,H,Min,Sec);             // add a new belief
       .send(front, achieve,start);                   // send a message to the front camera
       .send(back, achieve,start); 
       .send(notifier, achieve,start);
       !monitor.
      

+front(Object) : true
    <- .print("front camera detected: ", Object, "\n");
       !analyse(front,Object).

+!monitor : true
    <- .print("monitoring\n");
       .send(front, achieve,take_picture);
       .send(back, achieve,take_picture);
       .wait(10000);
       !monitor.

+!analyse(Camera, person) : true
    <- .print("analyse ", Camera, " detected a person\n");
       .send(notifier, achieve,alert).


+back(Object) : true
    <- .print("back camera detected: ", Object, "\n");
       !analyse(back,Object).

+!shutdown: true
    <- .print("controller shutdown\n");
       .send(front, achieve,shutdown);
       .send(back, achieve,shutdown);
       .send(notifier, achieve,shutdown).

{ include("$jacamo/templates/common-cartago.asl") }
{ include("$jacamo/templates/common-moise.asl") }

// uncomment the include below to have an agent compliant with its organisation
//{ include("$moise/asl/org-obedient.asl") }
