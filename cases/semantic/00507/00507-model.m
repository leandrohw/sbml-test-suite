(* 

category:      Test
synopsis:      Basic single forward reaction with three species in one
compartment using initialAssignment to set the initial value of one species.
componentTags: Compartment, Species, Reaction, Parameter, InitialAssignment 
testTags:      InitialAmount, ConstantSpecies
testType:      TimeCourse
levels:        2.2, 2.3, 2.4, 3.1
generatedBy:   Numeric

The model contains one compartment called C.  There are three
species called S1, S2 and S3 and two parameters called k1 and k2.  Species S3 is
labeled a constant species.  The model contains one reaction defined as:

[{width:30em,margin-left:5em}|  *Reaction*  |  *Rate*  |
| S1 -> S2 | $C * k2 * S1 * S3$  |]

The model contains one initialAssignment:

[{width:30em,margin-left:5em}| Variable | Formula |
 | S3 | $k1 * S2$  |]

Note: SBML's InitialAssignment construct override any declared initial
values.  In this case the initial value declared for species S3 is
consistent with the value returned by the InitialAssignment.

The initial conditions are as follows:

[{width:30em,margin-left:5em}| |*Value*  |*Units*  |
|Initial amount of S1        |$1$        |mole                      |
|Initial amount of S2        |$1.5$      |mole                      |
|Initial amount of S3        |$1.125$      |mole                      |
|Value of parameter k1       |$0.75$     |dimensionless |
|Value of parameter k2       |$2.7$      |litre mole^-1^ second^-1^ |
|Volume of compartment C     |$1$        |litre                     |]

The species values are given as amounts of substance to make it easier to
use the model in a discrete stochastic simulator, but (as per usual SBML
principles) their symbols represent their values in concentration units
where they appear in expressions.

*)

newcase[ "00507" ];

addCompartment[ C, size -> 1];
addSpecies[ S1, initialAmount->1 ];
addSpecies[ S2, initialAmount -> 1.5 ];
addSpecies[ S3, initialAmount-> 1.125, constant -> True ];
addParameter[ k1, value -> 0.75 ];
addParameter[ k2, value -> 2.7 ];
addInitialAssignment[ S3, math -> k1 * S2];
addReaction[ S1 -> S2, reversible -> False,
	     kineticLaw -> C * k2 * S1 *S3];

makemodel[]
