/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package eu.himeros.euporia;

import java.io.BufferedWriter;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileWriter;
import org.antlr.v4.runtime.ANTLRInputStream;
import org.antlr.v4.runtime.CommonTokenStream;
import org.antlr.v4.runtime.TokenStream;
import org.antlr.v4.runtime.tree.ParseTree;
import org.antlr.v4.runtime.tree.ParseTreeWalker;

/**
 *
 * @author federico
 */
public class Main extends EuporiaParser{
    static private FileInputStream fis;

    public Main(TokenStream input){
        super(input);
    }
    
    public static void main(String[] args) throws Exception{
	        fis=new FileInputStream(new File(args[0]));
		ANTLRInputStream input=new ANTLRInputStream(fis);
		EuporiaLexer lexer=new EuporiaLexer(input);
		CommonTokenStream tokens=new CommonTokenStream(lexer);
		Main parser=new Main(tokens);
		ParseTree tree=parser.start();
                ParseTreeWalker walker=new ParseTreeWalker();
                walker.walk(new ActualEuporiaListener(), tree);
                fis.close();
	}
}
