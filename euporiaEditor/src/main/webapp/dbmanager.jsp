<%-- 
    Document   : dbmanager
    Created on : Oct 21, 2015, 1:18:07 AM
    Author     : federico.boschetti@ilc.cnr.it
--%>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>
<%@page contentType="text/plain" pageEncoding="UTF-8"%>
<%@page import="java.io.BufferedReader"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.Statement"%>
<%@page import="java.sql.DriverManager"%>
<%@page import="java.sql.Connection"%>

<!DOCTYPE html>
<% 
    BufferedReader br=request.getReader();
    StringBuilder sb=new StringBuilder();
    String target=br.readLine().substring(2);
    String line;
    String text;
    while((line=br.readLine())!=null){
        sb.append(line);
    }
    text=sb.toString();
    text=text.replaceAll("><","> <");
    Class.forName("com.mysql.jdbc.Driver");
    Connection con = DriverManager.getConnection("jdbc:mysql://localhost:3306/####?useUnicode=true&characterEncoding=utf-8&user=****&password=****");    
    con.setAutoCommit(false);
    Statement stmt = con.createStatement();
    stmt.executeUpdate("update tragedies set annotation='"+text+"' where id="+target+";");
    con.commit();
    stmt.close();
    con.close();
%>
Saved