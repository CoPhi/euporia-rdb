// Generated from eu/himeros/euporia/Euporia.g4 by ANTLR 4.5.3
package eu.himeros.euporia;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import org.antlr.v4.runtime.ParserRuleContext;
import org.antlr.v4.runtime.tree.ErrorNode;
import org.antlr.v4.runtime.tree.TerminalNode;

/**
 * This class provides an empty implementation of {@link EuporiaListener}, which
 * can be extended to create a listener which only needs to handle a subset of
 * the available methods.
 */
public class ActualEuporiaListener extends EuporiaBaseListener {

    final int SINGLE = 1;
    final int FIRST = 2;
    final int MID = 3;
    final int LAST = 4;

    int id = 0;
    List<String> hashtagList;
    int trag = 0;
    List<Integer> begList;
    List<Integer> endList;
    int annotationId = 0;

    //String hashtag;
    int beg;
    int end;

    int wordRefType = 0;

    Connection con;
    Statement stmt;
    ResultSet rst;
    PreparedStatement hashtagInserter;

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterStart(EuporiaParser.StartContext ctx) {
        System.out.println("STARTED!");
        try{
            Class.forName("com.mysql.jdbc.Driver");
            con = DriverManager.getConnection("jdbc:mysql://localhost/******?useUnicode=true&characterEncoding=utf-8", "******", "******");
            con.setAutoCommit(false);
            stmt = con.createStatement();
            stmt.executeUpdate("delete from hashtags;");
            hashtagInserter = con.prepareStatement("insert into hashtags values(?,?,?,?,?);");
        }catch(ClassNotFoundException | SQLException ex){
            ex.printStackTrace(System.err);
        }
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitStart(EuporiaParser.StartContext ctx) {
        try{
            con.commit();
            hashtagInserter.close();
            stmt.close();
            con.close();
        }catch(Exception ex){
            ex.printStackTrace(System.err);
        }
        System.out.println("STOPPED!");
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterLine(EuporiaParser.LineContext ctx) {
        annotationId++;
        hashtagList = new ArrayList<>();
        begList = new ArrayList<>();
        endList = new ArrayList<>();
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitLine(EuporiaParser.LineContext ctx) {
        hashtagList.stream().forEach((hashtag) -> {
            for (int j = 0; j < begList.size(); j++) {
                id++;
                beg = begList.get(j);
                end = endList.get(j);
                //System.out.printf("%d\t%25s\t%d\t%d\t%d\t%d\n", id, hashtag.substring(1), trag, beg, end, annotationId);
                try{
                    hashtagInserter.setInt(1,id);
                    hashtagInserter.setString(2, hashtag.substring(1));
                    hashtagInserter.setInt(3,beg);
                    hashtagInserter.setInt(4,end);
                    hashtagInserter.setInt(5,annotationId);
                    hashtagInserter.executeUpdate();
                }catch(Exception ex){
                    ex.printStackTrace(System.err);
                }
            }
        });

    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterOpenLine(EuporiaParser.OpenLineContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitOpenLine(EuporiaParser.OpenLineContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterCloseLine(EuporiaParser.CloseLineContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitCloseLine(EuporiaParser.CloseLineContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterEol(EuporiaParser.EolContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitEol(EuporiaParser.EolContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterRef(EuporiaParser.RefContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitRef(EuporiaParser.RefContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterOpenRef(EuporiaParser.OpenRefContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitOpenRef(EuporiaParser.OpenRefContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterCloseRef(EuporiaParser.CloseRefContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitCloseRef(EuporiaParser.CloseRefContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterWordType(EuporiaParser.WordTypeContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitWordType(EuporiaParser.WordTypeContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterNum(EuporiaParser.NumContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitNum(EuporiaParser.NumContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterSId(EuporiaParser.SIdContext ctx) {
        int sid = Integer.parseInt(ctx.num().getText());
        trag = Integer.parseInt(("" + sid).substring(0, 2));
        switch (wordRefType) {
            case SINGLE:
                beg = sid;
                end = sid;
                break;
            case FIRST:
                beg = sid;
                break;
            case MID:
                break;
            case LAST:
                end = sid;
                break;
            default:
                break;
        }
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitSId(EuporiaParser.SIdContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterWordRefRanges(EuporiaParser.WordRefRangesContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitWordRefRanges(EuporiaParser.WordRefRangesContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterWordRefRange(EuporiaParser.WordRefRangeContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitWordRefRange(EuporiaParser.WordRefRangeContext ctx) {
        begList.add(beg);
        endList.add(end);
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterFirstWordRef(EuporiaParser.FirstWordRefContext ctx) {
        wordRefType = FIRST;
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitFirstWordRef(EuporiaParser.FirstWordRefContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterMidWordRef(EuporiaParser.MidWordRefContext ctx) {
        wordRefType = MID;
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitMidWordRef(EuporiaParser.MidWordRefContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterLastWordRef(EuporiaParser.LastWordRefContext ctx) {
        wordRefType = LAST;
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitLastWordRef(EuporiaParser.LastWordRefContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterSingleWordRef(EuporiaParser.SingleWordRefContext ctx) {
        wordRefType = SINGLE;
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitSingleWordRef(EuporiaParser.SingleWordRefContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterLineRef(EuporiaParser.LineRefContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitLineRef(EuporiaParser.LineRefContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterSpanText(EuporiaParser.SpanTextContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitSpanText(EuporiaParser.SpanTextContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterLId(EuporiaParser.LIdContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitLId(EuporiaParser.LIdContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterLineType(EuporiaParser.LineTypeContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitLineType(EuporiaParser.LineTypeContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterLNum(EuporiaParser.LNumContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitLNum(EuporiaParser.LNumContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterSep(EuporiaParser.SepContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitSep(EuporiaParser.SepContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterWordRef(EuporiaParser.WordRefContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitWordRef(EuporiaParser.WordRefContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterConds(EuporiaParser.CondsContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitConds(EuporiaParser.CondsContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterCond(EuporiaParser.CondContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitCond(EuporiaParser.CondContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterOpenCond(EuporiaParser.OpenCondContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitOpenCond(EuporiaParser.OpenCondContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterVarId(EuporiaParser.VarIdContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitVarId(EuporiaParser.VarIdContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterVlId(EuporiaParser.VlIdContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitVlId(EuporiaParser.VlIdContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterViId(EuporiaParser.ViIdContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitViId(EuporiaParser.ViIdContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterNot(EuporiaParser.NotContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitNot(EuporiaParser.NotContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterCloseCond(EuporiaParser.CloseCondContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitCloseCond(EuporiaParser.CloseCondContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterReading(EuporiaParser.ReadingContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitReading(EuporiaParser.ReadingContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterHashtags(EuporiaParser.HashtagsContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitHashtags(EuporiaParser.HashtagsContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterHashtag(EuporiaParser.HashtagContext ctx) {
        hashtagList.add(ctx.getText());
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitHashtag(EuporiaParser.HashtagContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterOpenBegSpan(EuporiaParser.OpenBegSpanContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitOpenBegSpan(EuporiaParser.OpenBegSpanContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterCloseBegSpan(EuporiaParser.CloseBegSpanContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitCloseBegSpan(EuporiaParser.CloseBegSpanContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterEndSpan(EuporiaParser.EndSpanContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitEndSpan(EuporiaParser.EndSpanContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterAny(EuporiaParser.AnyContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitAny(EuporiaParser.AnyContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void enterEveryRule(ParserRuleContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void exitEveryRule(ParserRuleContext ctx) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void visitTerminal(TerminalNode node) {
    }

    /**
     * {@inheritDoc}
     *
     * <p>
     * The default implementation does nothing.</p>
     */
    @Override
    public void visitErrorNode(ErrorNode node) {
    }
}
