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
       
    <c:set var="trag" value="${param.trag}"/>
    <c:if test="${trag==null}"><c:set var="trag" value="10048"/></c:if>
    <sql:query var="rs" dataSource="jdbc/trag">
        select * from tragedies where trag=${trag};
    </sql:query>
        
<!DOCTYPE html>
<html xmlns="http://www.w3.org/1999/xhtml">
    <head>
        <meta charset="UTF-8"/>
        <title>doc</title>
        <link rel="stylesheet" href="css/euporia.css" type="text/css"/>
        <script type="text/javascript">
            var target;
            var xhttp = new XMLHttpRequest();
            function state(targetParam){
                document.getElementById("b"+targetParam).innerHTML="Save";
            }
            function add(targetParam) {
                target = targetParam;
                document.getElementById("b"+target).innerHTML="Saving...";
                document.execCommand('insertHTML', false, '<p>☛&nbsp;[] &nbsp;☚</p>');
                var divContent = "an"+target + "\n" + document.getElementById("an"+target).innerHTML;
                xhttp.open('POST', 'dbmanager.jsp', true);
                xhttp.setRequestHeader("Content-type", "text/html");
                xhttp.send(divContent);
            }
            xhttp.onreadystatechange = function () {
                if (xhttp.readyState === 4 && xhttp.status === 200) {
                    document.getElementById("b"+target).innerHTML = xhttp.responseText;
                }
            }
        </script>
    </head>
    <body>
        <div style="overflow:hidden; resize:none">
            <p>
            <select onchange="window.location = 'index.jsp?trag=' + this.value">
                <c:forEach var="row" items="${titles.rows}">
                    <option value="${row.id}" <c:if test="${trag eq row.id}">selected="true"<c:set var="author" value="${row.author}"/><c:set var="work" value="${row.work}"/></c:if>>${row.author}, ${row.work}</option>
                </c:forEach>
            </select>
            </p>
            <h3>${author}, <i>${work}</i></h3>
        </div>
        <div style="overflow-y: scroll;height: 800px">
            <table>
                <thead>
                    <th></th>
                    <th></th>
                </thead>
                <tbody>
                <c:forEach var="row" items="${rs.rows}">
                    <tr>
                        <td class="text">${row.speech}<br/></td>
                        <td class="anno">
                            <br/>
                            <div class="anno" contentEditable="true" id="an${row.id}" onclick="state('${row.id}')">${row.annotation}</div>
                            <button id="b${row.id}" onClick="add('${row.id}')">Saved</button>
                            <button onClick="alert(document.getElementById('an${row.id}').innerHTML)">Show HTML</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>
        </div>
    </body> 
</html>
