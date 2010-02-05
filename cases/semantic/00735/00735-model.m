(* 

category:      Test
synopsis:      One reactions and two rate rules with four species in a compartment. 
componentTags: Compartment, Species, Reaction, Parameter, RateRule, InitialAssignment 
testTags:      InitialAmount, LocalParameters
testType:      TimeCourse
levels:        2.2, 2.3, 2.4, 3.1
generatedBy:   Numeric

The model contains one compartment called C.  There are four
species called S1, S2, S3 and S4 and two parameters called k1 and k2.  The
model contains one reaction defined as:

[{width:30em,margin-left:5em}|  *Reaction*  |  *Rate*  |
| S1 -> S2 | $k1 * S1 * C$  |]

Reaction S1 -> S2 defines one local parameter k1 which has a
scope local to the defining reaction and is different from the global parameter k1
used in the InitialAssignment.

The model contains two rules:

[{width:30em,margin-left:5em}|  *Type*  |  *Variable*  |  *Formula*  |
 | Rate | S3 | $k2  *  S4$  |
 | Rate | S4 | $-k2  *  S4$  |]

The model contains one initialAssignment:

[{width:30em,margin-left:5em}| Variable | Formula |
 | S1 | $p1/0.5$  |]

Note: InitialAssignments override any declared initial values.  In this case the 
value of species S1 is not declared by the model definition.  The calculated value should be used.

The initial conditions are as follows:

[{width:30em,margin-left:5em}|       |*Value*          |*Units*  |
|Initial amount of S1                |$ undeclared$ |mole                      |
|Initial amount of S2                |$          2.0$ |mole                      |
|Initial amount of S3                |$          1.5$ |mole                      |
|Initial amount of S4                |$            4$ |mole                      |
|Value of parameter k1                |$         0.75$ |mole litre^-1^ |
|Value of parameter k2               |$         0.5$ |second^-1^ |
|Value of local parameter k1               |$         0.8$ |second^-1^ |
|Volume of compartment C |$            1$ |litre                     |]

The species values are given as amounts of substance to make it easier to
use the model in a discrete stochastic simulator, but (as per usual SBML
principles) their symbols represent their values in concentration units
where they appear in expressions.

*)

newcase[ "00735" ];

addCompartment[ C, size -> 1 ];
addSpecies[ S1 ];
addSpecies[ S2, initialAmount -> 2.0];
addSpecies[ S3, initialAmount -> 1.5];
addSpecies[ S4, initialAmount -> 4];
addParameter[ k1, value -> .75 ];
addParameter[ k2, value -> .5 ];
addInitialAssignment[ S1, math -> k1/0.5];
addRule[ type->RateRule, variable -> S3, math -> k2  *  S4];
addRule[ type->RateRule, variable -> S4, math -> -k2  *  S4];
addReaction[S1 -> S2, reversible -> False,
	     kineticLaw -> k1 * S1 * C, parameters -> {k1 -> 0.8} ];

makemodel[]
