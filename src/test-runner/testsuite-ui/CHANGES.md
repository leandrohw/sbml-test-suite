### Changes in release 3.3.0-beta

* There is a new installer for Mac OS&nbsp;X. The installation is now distributed as an OS&nbsp;X <code>.pkg</code> installer file.  By default, it will install the SBML Test Runner into the <code>/Applications</code> folder on the user's computer.

* This release contains hundreds of new semantic test cases, numbers 01219&ndash;1777, written by Lucian P. Smith.  They test many more SBML features and rules. Important note: tests 01234&#8211;01292 specifically test models that follow the release candidate specification of [SBML Level 3 Version 2](http://sbml.org/Documents/Specifications/SBML_Level_3/Version_2/Core/Release_1), which encode elements and situations that were not present or illegal in SBML Level&nbsp;3 Version&nbsp;1. If your simulator uses libsbml, it will **need the latest experimental version of [libSBML](http://sbml.org/Software/libSBML), 5.14.0 or later**. Please see the file <code>NEWS</code> (provided with the distribution) for more details about the changes to the test cases.

* The SBML Test Suite home repository has been moved to [GitHub](https://github.com/sbmlteam/sbml-test-suite).  New development will take place in the branch called [&#8216;develop&#8217;](https://github.com/sbmlteam/sbml-test-suite/tree/develop).  Each time we make a new release, we will merge the changes into branch &#8216;master&#8217; and start the next new developments in &#8216;develop&#8217;.

* A few things have been cleaned up in past tests. Examples include model identifiers of a few test models that were misleading (now fixed), and a few tests that were designed to test species in multiple compartments were at some point accidentally changed so that all the species were put into a single compartment (they have been redistributed appropriately now).

* The issue tracker for the Test Suite is now the GitHub tracker: <a href="https://github.com/sbmlteam/sbml-test-suite/issues">https://github.com/sbmlteam/sbml-test-suite/issues</a>. Lucian Smith migrated the previous issues from the SourceForce tracker, so they are now in the GitHub tracker, for history. We thank the guides by <a href="https://github.com/mephenor/JSBML-Migration-Guide/wiki/">Thomas Zajac</a> and <a href="https://github.com/cmungall/gosf2github">Chris Mungall</a> for helpful info about how to achieve this migration.

* With the addition of FBC v2 tests, the <code>packagesPresent</code> line in the <code>.m</code> file can now include <code>fbc_v1</code> or <code>fbc_v2</code>, depending on which version of the test it is.  The original <code>fbc</code> tag is still present.  In addition, a new FBC test tag <code>fbc:NonStrict</code> is now provided for FBC v2 models where the <code>strict</code> flag has been set to <code>false</code>.</code>

* The SBML Test Runner now monitors for file changes in the currently-displayed test case.  If the application's output `.csv` file is changed outside the runner (e.g., by manually editing the file), it should now notice the changes and update the display.  Note that for architectural reasons, only the case being displayed is so monitored.