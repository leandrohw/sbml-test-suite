(*

category:        Test
synopsis:        A species conversion factor for non-persistent event.
componentTags:   Compartment, EventWithDelay, Parameter, Reaction, Species
testTags:        Amount, ConversionFactors, EventIsNotPersistent
testType:        TimeCourse
levels:          3.1, 3.2
generatedBy:     Analytic
packagesPresent: 

 In this model, a species conversion factors is set for a species not reset partway through the simulation by a non-persistent event.

The model contains:
* 2 species (S1, S2)
* 1 parameter (s1_cf)
* 1 compartment (C)

There is one reaction:

[{width:30em,margin: 1em auto}|  *Reaction*  |  *Rate*  |
| J0: S1 -> S2 | $0.01$ |]

The conversion factor for the species 'S1' is 's1_cf'


There is one event:

[{width:40em,margin: 1em auto}|  *Event*  |  *Trigger*  |  *Persistent*  |  *Delay*  | *Event Assignments* |
| E0 | $(S1 <= 1.88) && (S1 > 1.84)$ | false | $1$ | $S2 = 3$ |
|  |  |  |  | $S1 = 6$ |]

The initial conditions are as follows:

[{width:35em,margin: 1em auto}|       | *Value* | *Constant* |
| Initial amount of species S1 | $2$ | variable |
| Initial amount of species S2 | $3$ | variable |
| Initial value of parameter s1_cf | $5$ | constant |
| Initial volume of compartment 'C' | $1$ | constant |]

The species' initial quantities are given in terms of substance units to
make it easier to use the model in a discrete stochastic simulator, but
their symbols represent their values in concentration units where they
appear in expressions.

Note: The test data for this model was generated from an analytical
solution of the system of equations.

*)
