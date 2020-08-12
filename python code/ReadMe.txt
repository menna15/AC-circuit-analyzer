NOTES :
*******
Take in consideration :
1) You will find file named 'YC' write the netlist in it as it's showen below  
2) the results of the circuit will be presented in file named 'results'
3) The letters should be All Capital & the unique symbol for each element.
4) The Spaces between the Given Data is very important .
5) Select any node and Give it number "0" (start counting from 0) , the nodes should be only numbers (e.g : 0 ,1,2...) not (n1,n2,n3,..)


^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
NetList Format:
***************

for omega value ->
W value                //the letter should be "W" & capaital , <value> is the value of omega 

for Resistor ->
R<num> node1 node2 resistance  // <num> is the number of the element in the circuit (eg: R1 ,R2 ..)
  
for inductor ->
L<num> node1 node2 inductance  // <num> is the number of the element in the circuit (eg: L1 ,L2 ..)
 
for capacitor ->
C<num> node1 node2 Capacitance // <num> is the number of the element in the circuit (eg: C1 ,C2 ..)
 
for Indepentent Sources:
........................
for voltage Source ->
VS<num> node1 node2 value phase   ///For All Voltage sources except for ccvs node1 is the "+" of the source ,node2 is the "-" of it , <value> is the magnitude .
 
for Current Source ->
IS<num> node1 node2 value phase   /// For All Current Sources except for cccs The node at the arrow's tail is "node1" , The node at the arrow's head is "node2" ( positive current flows into node1 and out of node2).


for Dependent Sources :
+++++++++++++++++++++++

for voltage source controlled Current Source (vccs) ->

G<num> node1 node2 Dnode1 Dnode2 DependencyFactor /// Dnode1 ,Dnode2 are the nodes where the controlled voltage is across, DependencyFactor (e.g "4vo" is the 4).


for voltage source controlled voltage Source (vcvs) ->
E<num> node1 node2 Dnode1 Dnode2 DependencyFactor  /// Dnode1 ,Dnode2 are the nodes where the controlled voltage is across, DependencyFactor (e.g "4vo" is the 4).


for Current Controlled Current Source (cccs) ->

first:
** seperate the node of the Element(R,L,C) where the current passing for example :
if the current passes from node 1 to node 2 in element(e.g: R) Write the Element like that in Netlist:
R<num> node1 node<a> resistance // a can be any symbol but not chosen before.
 
Second:
** Add Voltage Source " zero volt" (Important: before Entering the Data of the Dependent Source)
in case (cccs)
symbol of it should be (VF)*** important***
VF<num> node2 node<a> 0 0  // node2 of the element that current passing through , node<a> is the seperating node .first "0" is the magnitude, second for phase.

Third:
**the cccs in Netlist Will be :
F<num> node1 node2 VF<num> DependencyFactor //*** important*** node1 is The node at the arrow's head ,node2 is The node at the arrow's tail  current passing, <num> should be the same of the zero volt"VF"<num>. 



for Current Controlled Voltage Source (ccvs) ->

first:
** seperate the node of the Element(R,L,C) where the current passing for example :
if the current passes from node 1 to node 2 in element(e.g: R) Write the Element like that in Netlist:
R<num> node1 node<a> resistance // a can be any symbol but not chosen before.
 
Second:
** Add Voltage Source " zero volt" (Important: before Entering the Data of the Dependent Source)
in case (ccvs)
symbol of it should be (VH)*** important***
VH<num> node2 node<a> 0 0  // node2 of the element that current passing through , node<a> is the seperating node .first "0" is the magnitude, second for phase.

Third:
**the ccvs in Netlist Will be :
H<num> node1 node2 VH<num> DependencyFactor // *** important*** node1 is the "-" of the source ,node2 is the "+"  , <num> should be the same of the zero volt"VH"<num>. 
