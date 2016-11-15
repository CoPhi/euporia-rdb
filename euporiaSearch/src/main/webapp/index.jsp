<%-- 
    Document   : index
    Created on : Nov 10, 2016, 3:07:28 PM
    Author     : federico
--%>

<%-- 
    Document   : index
    Created on : Oct 21, 2015, 12:22:46 AM
    Author     : federico.boschetti@ilc.cnr.it
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<sql:query var="titles" dataSource="jdbc/trag">
    select * from titles;
</sql:query>


<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" type="text/css" href="css/euporiaSearch.css">
        <script type="text/javascript" src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.1/jquery.min.js"></script>
        <script type="text/javascript" src="js/accordion.js"></script>
        <title>JSP Page</title>
    </head>
    <body>
        <h1>Euporia Search</h1>
        <form action="index.jsp" method="get">
            <input id="h1" name="h1" type="text" value="${param.h1}" title="first key-word"/>
            <input id="h2" name="h2" type="text" value="${param.h2}" title="second key-word"/>
            <input id="befbeg" name="befbeg" size="6" value="${param.befbeg}" type="text" title="words before beginning"/>
            <input id="aftend" name="aftend" size="6" value="${param.aftend}" type="text" title="words after end"/>
            <input id="hbefbeg" name="hbefbeg" size="6" value="${param.hbefbeg}" type="text" title="words before beginning (in details)"/>
            <input id="haftend" name="haftend" size="6" value="${param.haftend}" type="text" title="words after end (in details)"/>
            <input id="run" type="submit" value="Search"/>
        </form>
        <sql:query var="result" dataSource="jdbc/trag">
            call intersectproc(?,?,?,?)
            <sql:param value="${param.h1}"/>
            <sql:param value="${param.h2}"/>
            <sql:param value="${param.befbeg}"/>
            <sql:param value="${param.aftend}"/>
        </sql:query>
        <div class="accordion">
            <c:forEach var="row" items="${result.rows}">
                <div class="accordion-section">
                    <c:set var="accId" value="${accId+1}"/>
                    <a id='t${accId}' class="accordion-section-title" href="#accordion-${accId}">
                        ${row.bauth}${row.bwork} ${row.bline} ${row.btoken} - ${row.eline} ${row.etoken}<br/>
                    </a>
                    <sql:query var="hashtags" dataSource="jdbc/trag">
                        call showhashtags(${row.beg},${row.end},${param.hbefbeg},${param.haftend})
                    </sql:query>
                    <div id="accordion-${accId}" class="accordion-section-content">
                        <c:forEach var="hrow" items="${hashtags.rows}">
                            <b>${hrow.hashtag}</b> ${hrow.bauth}${hrow.bwork} ${hrow.bline} ${hrow.btoken} - ${hrow.eline} ${hrow.etoken}<br/> 
                        </c:forEach>
                    </div>
                </div>
            </c:forEach>
        </div>
    </body>
</html>
