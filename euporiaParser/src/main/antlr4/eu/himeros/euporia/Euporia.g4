/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

grammar Euporia;

start : line+ EOF;
line : openLine ref conds? (varId? hashtags LATIN_WORD*|varId reading)? closeLine eol?;
//line : openLine ref conds? (varId reading)? closeLine eol?;
openLine : BEG;
closeLine : END;
eol : NEWLINE;
ref : openRef (wordRefRanges)? closeRef;
//ref : openRef (lineRef wordRefRanges)? endRef;
openRef : L_BRAC;
closeRef : R_BRAC;
wordType : S;
num : NUM;
sId : wordType num;
wordRefRanges : wordRefRange (UNDERSCORE wordRefRange)+|wordRefRange;
wordRefRange : (firstWordRef midWordRef+ lastWordRef)|(firstWordRef lastWordRef)|singleWordRef;
firstWordRef : wordRef;
midWordRef : wordRef;
lastWordRef : wordRef;
singleWordRef : wordRef;
lineRef : lNum|openBegSpan lId closeBegSpan spanText endSpan;
spanText : ((GREEK_WORD+ PUNCT?)|((LATIN_WORD|NUM) PUNCT?)|SEP)*;
lId : lineType lNum;
lineType : L;
lNum : NUM;
sep : SEP;
wordRef : sep? lineRef? openBegSpan sId closeBegSpan spanText endSpan|any*? sId any*?;
conds : cond+;
cond : openCond varId+ closeCond;
openCond : L_CURL;
varId : (not? VLTYPE vlId)|(not? VITYPE viId);
vlId : NUM+ UNDERSCORE NUM+ LATIN_WORD?;
viId : NUM+ UNDERSCORE NUM+ LATIN_WORD?;
not : NOT;
closeCond : R_CURL;
//reading : (GREEK_WORD+ PUNCT)* (LATIN_WORD PUNCT?)+;
//reading : (GREEK_WORD+ PUNCT?)* ((LATIN_WORD|NUM) PUNCT?)*;
reading : ((GREEK_WORD+ PUNCT?)|((LATIN_WORD|NUM) PUNCT?)|SEP)*;
hashtags : (any*? hashtag any*?)+;
hashtag : HASHTAG;
openBegSpan : OPEN_BEG_SPAN;
closeBegSpan : CLOSE_BEG_SPAN;
endSpan : END_SPAN;

any : ~(BEG|END|EOF);

fragment HASH : '#';
NOT : '!';
BEG : '☛';
END : '☚';
S : 's';
L : 'l';
NUM : [0-9]+;
SEP : '...'|'/';
VLTYPE : '@vl:';
VITYPE : '@vi:';
LATIN_WORD : ('a'..'z'|'A'..'Z'|'á'|'à'|'ä'|'é'|'è'|'ë'|'í'|'ì'|'ï'|'ó'|'ò'|'ö'|'ú'|'ù'|'ü')+;
HASHTAG: HASH NOT? (LATIN_WORD|UNDERSCORE)+;
NEWLINE : ('\n'|'\r'|'\r\n')+;
OPEN_BEG_SPAN : '<span id="' ;
CLOSE_BEG_SPAN : '"' (' class="line"')? '>';
fragment GREEK_LETTER : '\u0370'..'\u0386'|'\u0388'..'\u03ff'|'\u1f00'..'\u1fff'|'\u2019'|'·'|'&'('a'..'z')+';';
GREEK_WORD : ('*'' '?)+|GREEK_LETTER+;
END_SPAN : '</span>' ;
UNDERSCORE : '_'|'~';
L_BRAC : '[';
R_BRAC : ']';
L_CURL : '{';
R_CURL : '}';
PUNCT : '.'|','|';'|':';
WS : (' '){skip();};
EMPTY : '☛' '[' ']' '☚' '\n'{skip();}; 
ML_COMMENT : '/*' .+? '*/'{skip();};
EXT_PUNCT : PUNCT |'<'|'>'|'"'|'='|' ';
ANY : .+?;
