# Digital-Systems-Elevator-In-A-Slighty-Different-Way

# Summary

The project consists of building an elevator controller for a 4-story building (with the ground floor being one of these floors) using Verilog. We utilized a Moore machine—a Finite-State Machine (FSM) which, for comprehension reasons, was a better option compared to Mealy machines—to manage the movement logic. For the Moore machine, we used behavioral language, and for the validation code, we used simple logic gates and an electrical circuit via an electrical schematic. 

A security system requiring a PIN was also implemented for access to the 2nd and 3rd floors. The PIN is structured as follows:

`"destination floor (2nd or 3rd)" + "digit 1" + "digit 2" + "digit 3"`

* **Digit 1:** Corresponds to the remainder of the division by 4 of the sum of the older student's ID number. 
* **Digit 2:** Corresponds to the remainder of the division by 4 of the sum of the younger student's ID number. 
* **Digit 3:** Corresponds to the remainder of the division by 4 of the sum of both group students' ID numbers (2).

The system also integrates priority management features between internal and external calls, timed door control, and obstruction sensors, all operating under a 1Hz clock signal. The system's operation was verified by comparing it with other existing online projects and through our own knowledge derived from the *Digital Systems* book by Professor Morgado Dias.
