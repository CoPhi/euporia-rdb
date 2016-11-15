/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eu.himeros.euporia;

import java.io.IOException;
import java.io.StringReader;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.List;
import org.jdom2.Document;
import org.jdom2.Element;
import org.jdom2.JDOMException;
import org.jdom2.input.SAXBuilder;
import org.jdom2.xpath.XPathExpression;
import org.jdom2.xpath.XPathFactory;

/**
 *
 * @author federico
 */
public class PseudoCtsMaker {

    private Connection con;
    private PreparedStatement pstmt;
    private Statement stmt;
    private ResultSet rst;

    private SAXBuilder builder;
    private Document doc;
    private XPathFactory xpathFactory;
    private XPathExpression<Element> xpathExpression;

    public PseudoCtsMaker() throws Exception {
        try {
            builder = new SAXBuilder();
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost/******?useUnicode=true&characterEncoding=utf-8", "******", "******");
            con.setAutoCommit(false);
            stmt = con.createStatement();
            stmt.executeUpdate("delete from tokens;");
            rst = stmt.executeQuery("select * from tragedies");
            pstmt = con.prepareStatement("insert into tokens values(?,?,?,?,?,?,?,?);");
        } catch (ClassNotFoundException | SQLException ex) {
            ex.printStackTrace(System.err);
        }
    }

    public void make() throws Exception {
        while (rst.next()) {
            parse(rst);
        }
        rst.close();
        stmt.close();
        pstmt.close();
        con.close();
    }

    public void parse(ResultSet rst) {
        int id = 0;
        int line = 0;
        String lineadd="";
        int speechid = 0;
        int progt = 0;
        String token = "";
        String word = "";
        String br = "";
        try {
            String speech = rst.getString("speech");
            doc = builder.build(new StringReader(speech));
            Element root = doc.getRootElement();
            List<Element> children = root.getChildren();
            for (int i = 0; i < children.size(); i++) {
                Element element = children.get(i);
                if ("br".equals(element.getName())) {
                    continue;
                } else if ("span".equals(element.getName())) {
                    if ("speaker".equals(element.getAttributeValue("class"))) {
                        continue;
                    } else if ("line".equals(element.getAttributeValue("class"))) {
                        try {
                            lineadd = element.getText();
                            line = Integer.parseInt(lineadd);
                        } catch (Exception ex) {
                            try{
                                line = Integer.parseInt(lineadd.replaceAll("[^0-9]",""));
                            }catch(Exception exIn){
                                line=0;
                            }
                        }
                        continue;
                    }
                    token = element.getText();
                    id=Integer.parseInt(element.getAttributeValue("id").substring(1));
                }
                Element nextElement;
                try {
                    nextElement = children.get(i + 1);
                    if ("br".equals(nextElement.getName())) {
                        br = "/";
                    } else {
                        br = "";
                    }
                } catch (IndexOutOfBoundsException ioobex) {
                    br = "";
                }
                if(line>0) lineadd=""+line;
                speechid=rst.getInt("id");
                progt=rst.getInt("progt");
                id=progt*100000+id;
                System.out.printf("%d\t%d\t%s\t%d\t%d\t%s\t%s\t%s\n",id,line,lineadd,speechid,progt,token,word,br);
                pstmt.setInt(1,id);
                pstmt.setInt(2,line);
                pstmt.setString(3,lineadd);
                pstmt.setInt(4,speechid);
                pstmt.setInt(5,progt);
                pstmt.setString(6,token);
                pstmt.setString(7,word);
                pstmt.setString(8,br);
                pstmt.executeUpdate();
            }
            con.commit();
        } catch (SQLException | JDOMException | IOException ex) {
            ex.printStackTrace(System.err);
        }
    }

    public static void main(String[] args) throws Exception {
        PseudoCtsMaker pseudoCtsMaker = new PseudoCtsMaker();
        pseudoCtsMaker.make();
    }
}
