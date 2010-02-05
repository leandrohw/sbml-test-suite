(* 

category:      Test
synopsis:      Basic two reactions with four species in one 2D compartment
               and one functionDefinition.
componentTags: Compartment, Species, Reaction, Parameter, FunctionDefinition 
testTags:      InitialAmount, 2D-Compartment, NonUnityCompartment
testType:      TimeCourse
levels:        2.1, 2.2, 2.3, 2.4, 3.1
generatedBy:   Numeric

The model contains one compartment called "compartment".  There are four
species named S1, S2, S3 and S4 and two parameters named k1 and k2.
Compartment "compartment" is 2-dimensional.  The model contains two
reactions defined as:

[{width:30em,margin-left:5em}|  *Reaction*  |  *Rate*  |
| S1 + S2 -> S3 + S4 | $multiply(k1,multiply(S1,S2)) * compartment$  |
| S3 + S4 -> S1 + S2 | $k2 * S3 * S4 * compartment$  |]


The model contains one functionDefinition defined as:

[{width:30em,margin-left:5em}|  *Id*  |  *Arguments*  |  *Formula*  |
 | multiply | x, y | $x * y$ |]


The initial conditions are as follows:

[{width:30em,margin-left:5em}|       |*Value*          |*Units*  |
|Initial amount of S1              |$0.9 \x 10^-2$ |mole                      |
|Initial amount of S2              |$1.1 \x 10^-2$ |mole                      |
|Initial amount of S3              |$1.2 \x 10^-2$ |mole                      |
|Initial amount of S4              |$1.0 \x 10^-2$ |mole                      |
|Value of parameter k1             |$12.75 \x 10^1$ |metre^2^ mole^-1^ second^-1^ |
|Value of parameter k2             |$0.25 \x 10^1$ |metre^2^ mole^-1^ second^-1^ |
|Area of compartment "compartment" |$         1.98$ |metre^2^                  |]

The species values are given as amounts of substance to make it easier to
use the model in a discrete stochastic simulator, but (as per usual SBML
principles) their symbols represent their values in concentration units
where they appear in expressions.

*)

newcase[ "00284" ];

addFunction[ multiply, arguments -> {x, y}, math -> x * y];
addCompartment[ compartment, spatialDimensions-> 2, size -> 1.98 ];
addSpecies[ S1, initialAmount -> 0.9 10^-2];
addSpecies[ S2, initialAmount -> 1.1 10^-2];
addSpecies[ S3, initialAmount -> 1.2 10^-2];
addSpecies[ S4, initialAmount -> 1.0 10^-2];
addParameter[ k1, value -> 12.75 10^1 ];
addParameter[ k2, value -> 0.25 10^1 ];
addReaction[ S1 + S2 -> S3 + S4, reversible -> False,
	     kineticLaw -> multiply[k1,multiply[S1,S2]] * compartment ];
addReaction[ S3 + S4 -> S1 + S2, reversible -> False,
	     kineticLaw -> k2 * S3 * S4 * compartment ];

makemodel[]
