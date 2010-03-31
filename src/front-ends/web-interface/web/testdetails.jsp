<%-- 
 * @file    testdetails.jsp
 * @brief   Display the details of a single test case result.
 * @author  Kimberly Begley
 * @author  Michael Hucka
 * @date    Created Jul 30, 2008, 9:25:21 AM
 * @id      $Id$
 * $HeadURL$
 *
 * ----------------------------------------------------------------------------
 * This file is part of the SBML Test Suite.  Please visit http://sbml.org for 
 * more information about SBML, and the latest version of the SBML Test Suite.
 *
 * Copyright 2008-2010 California Institute of Technology.
 * Copyright 2004-2007 California Institute of Technology (USA) and
 *                     University of Hertfordshire (UK).
 * 
 * This library is free software; you can redistribute it and/or modify it
 * under the terms of the GNU Lesser General Public License as published by
 * the Free Software Foundation.  A copy of the license agreement is provided
 * in the file named "LICENSE.txt" included with this software distribution
 * and also available at http://sbml.org/Software/SBML_Test_Suite/License
 * ----------------------------------------------------------------------------
--%>

<%@ page import="java.util.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.io.*" %>
<%@ page import="java.net.*" %>
<%@ page import="java.math.*" %>

<%@ page import="sbml.test.UserTestCase" %>
<%@ page import="sbml.test.UserTestResult" %>
<%@ page import="sbml.test.TestCase" %>
<%@ page import="sbml.test.CasesTagsMap" %>

<%@ include file="sbml-head.html"%>
<%@ include file="sbml-top.html"%>

<% 
// We get a number of things via the URL handed to us in the link
// that the user clicked.  The rest we get from the context.

// Each square in the summary map generated by showresults.jsp is a link.
// 'testname' is handed as a parameter in the URL of the link (and hence
// is a request parameter, not a session variable).  It gives the case
// number for this page.

String testname = request.getParameter("testname"); 

// showresults.jsp stores the result vector (originally generated by
// UploadUnzipTest) in the session, as variable 'testResults'.

Vector<UserTestResult> results
    = (Vector<UserTestResult>) session.getAttribute("testResults");

UserTestResult thisResult = results.get(Integer.parseInt(testname));

// Get the test reference data for this case, but don't get it via
// thisResult because that might be null if this case wasn't in the
// set uploaded by the user.

String testdir    = getServletContext().getRealPath("/test-cases");
TestCase thisCase = new TestCase(testdir, testname);

%>

<div id='pagetitle'>
<h1 class='pagetitle'>Details for SBML Test Case #<%=testname%></h1>
</div><!-- id='pagetitle' -->
<div style="float: right; margin: 0 0 1em 2em; padding: 0 0 0 5px">
  <img src="http://sbml.org/images/8/80/Icon-online-test-suite-64px.jpg" border="0">
</div>

<%

if (thisResult == null)
{
    out.println("<p><b><font color=\"GoldenRod\">");
    out.println("Note: Results for this case were <i>not</i> part of your uploaded ");
    out.println("test results.</font></b></p>");
}
%>

<p>
<em>Synopsis of test case</em>: <%=thisCase.getSynopsis()%><BR>
</p>

<%
if (thisResult != null)
{
    out.println("<p><em>Result</em>:\n");

    if (thisResult.getNumDifferences() > 0)
    {
        UserTestCase theCase    = thisResult.getUserTestCase();
        BigDecimal[][] diffs    = thisResult.getDifferences();
        BigDecimal[][] expected = theCase.getExpectedData();
        BigDecimal[][] userData = theCase.getUserData();
        Vector<String> varNames = theCase.getTestVars();
        int numRows             = theCase.getTestNumRows();
        int numVars             = theCase.getTestNumVars();
        int points              = numRows * numVars;
%>
        <font color="darkred"><b><font color="darkred">Failed</font></b> at
        <%=thisResult.getNumDifferences()%> of <%=points%> data points</font><BR>

	<p>The table below indicates which data points
	did not come close enough to the expected values.  Green
        values are the expected data values; red values appeared in the
        uploaded results but do not match the expected value within the
        error tolerances. The tolerances for this test case (#<%=testname%>) are:

        <table class="borderless-table" style="margin-left: 2em">
        <tr>
            <td width="150px">Absolute tolerance (T<sub>a</sub>)</td>
            <td width="14px">=</td>
            <td><%=theCase.getTestAbsoluteTol()%></td>
        </tr><tr>
            <td>Relative tolerance (T<sub>r</sub>)</td>
            <td>=</td>
            <td><%=theCase.getTestRelativeTol()%></td>
        </tr>
        </table>

        The following is how the errors are determined.  
        Let E<sub>ij</sub> stand for the expected values for this test, and
        let U<sub>ij</sub> stand for the the uploaded result values.  
        A data point is <i>within tolerances</i> if and only if
	<blockquote style="margin-left: 2em">
            <font color="#777" size="+1">|</font>E<sub>ij</sub> - U<sub>ij</sub><font color="#777" size="+1">|</font>
             < T<sub>r</sub> &times; 
            <font color="#777" size="+1">(</font>|E<sub>ij</sub>| + T<sub>a</sub><font color="#777" size="+1">)</font>
        </blockquote>

        <p>You can hover the mouse pointer over a table entry to be shown
        the difference in the values.

        <p><table class="sm-padding">
	<tr>
            <th>Time</th>
<%
	for (String name : varNames)
	    out.println("<th>" + name + "</th>");
%>
        </tr>
<%
	for (int r = 0; r < numRows; r++)
        {
            out.println("<tr>");
	    for (int c = 0; c < expected[0].length; c++)
            {
                if (diffs[r][c] != null)
                    out.println("<td title=\"Difference: " + diffs[r][c] + "\">");
                else
                    out.println("<td>");
                out.println("<span style=\"font-size: 7pt; color: green\">"
                            + expected[r][c] + "</span>");
                if (diffs[r][c] != null)
                    out.println("<br><span style=\"font-size: 7pt; color: red\">" 
                                + userData[r][c] + "</span>");
                out.println("</td>");
            }
            out.println("</tr>");            
        }
%>
        </table>
<%
    }
    else if (thisResult.hasError())
    {
%>
        <b>Skipped</b> due to the following reason(s):<br>
        <blockquote style="width: 80%; border: 1px solid gold; padding: 0.5em">
            <%=thisResult.getErrorMessage()%>
        </blockquote>
<%
    }
    else
    {
%>
        <b><font color="green">Passed!</font></b><BR>
<%
    }
}
%>

<p>
<em>Component tags involved in test case</em>: <%=thisCase.getComponentTagsAsString()%>. <BR>
</p>
<p>
<em>Test tags involved in test case</em>: <%=thisCase.getTestTagsAsString()%>.<BR>
</p>

<p>
The following is a plot of the <b>expected</b> results:
</p>

<center>
    <img style="margin-left: -80px" 
         src="http://sbml.org:8080/test_suite/test-cases/<%=testname%>/<%=thisCase.getPlotFileName()%>"
         align="center" alt="plot"> 
</center>

<p>
<style type='text/css'>
table td, th {
  font-size: 9pt;  
  padding: 2px;
}

table {
  margin: 1em auto 1em auto;
  width: 75% !important;
}
</style>
<c:import url="<%="file://" + thisCase.getHTMLFile().getPath()%>" />
</p>

<p>	
<center>
  <a href="http://sbml.org/Facilities/Online_SBML_Test_Suite">
    <img border="0" align="center" 
         src="http://sbml.org/images/8/83/Icon-red-left-arrow.jpg">
    Return to the Online SBML Test Suite front page.
  </a>
</center>
</p>

<%@ include file="sbml-bottom.html"%>
