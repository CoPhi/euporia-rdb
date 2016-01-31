/*
 * Copyright (C) 2016 Federico Boschetti, Venezia - ITALY
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <http://www.gnu.org/licenses/>.
 */

grammar Euporia;

start : line+ EOF;
line : openLine ref conds? (varId? hashtags LATIN_WORD*|varId reading)? closeLine eol?;
openLine : BEG;
ref : openRef (lineRef wordRefRanges)? endRef;
openRef : L_BRAC;
lineRef : openBegSpan lId closeBegSpan spanText endSpan|NUM;
endRef : R_BRAC;
conds : cond+;
cond : openCond varId+ closeCond;
openCond : L_CURL;
varId : (not? VLTYPE vlId)|(not? VITYPE viId);
vlId : NUM+ UNDERSCORE NUM+ LATIN_WORD?;
viId : NUM+ UNDERSCORE NUM+ LATIN_WORD?;
not : NOT;
closeCond : R_CURL;
hashtags : hashtag+;
hashtag : t=HASHTAG{write($t);};
reading : (GREEK_WORD+ PUNCT)* (LATIN_WORD PUNCT?)+;
closeLine : END;
eol : NEWLINE;
wordRefRanges : wordRefRange (UNDERSCORE wordRefRange)?;
wordRefRange : singleWordRef|firstWordRef midWordRef*? lastWordRef;
firstWordRef : wordRef;
midWordRef : wordRef;
lastWordRef : wordRef;
singleWordRef : wordRef;
wordRef : NUM? openBegSpan sId closeBegSpan spanText endSpan SEP?;
openBegSpan : OPEN_BEG_SPAN;
sId : wordType sNum;
lId : lineType lNum;
sNum : NUM;
lNum : NUM;
wordType : S;
lineType : L;
closeBegSpan : CLOSE_BEG_SPAN;
spanText : (NUM|LATIN_WORD|GREEK_WORD|SEP)*;
endSpan : END_SPAN;

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
LATIN_WORD : ('a'..'z'|'A'..'Z')+;
HASHTAG: HASH NOT? (LATIN_WORD|UNDERSCORE)+;
NEWLINE : ('\n'|'\r'|'\r\n')+;
OPEN_BEG_SPAN : '<span id="' ;
CLOSE_BEG_SPAN : '"' (' class="line"')? '>';
fragment GREEK_LETTER : '\u0370'..'\u0386'|'\u0388'..'\u03ff'|'\u1f00'..'\u1fff'|'\u2019'|'&'('a'..'z')+';';
GREEK_WORD : ('*'' '?)+|GREEK_LETTER+;
END_SPAN : '</span>' ;
UNDERSCORE : '_';
L_BRAC : '[';
R_BRAC : ']';
L_CURL : '{';
R_CURL : '}';
PUNCT : '.'|','|';'|':';
//L_PARE : '(';
//R_PARE : ')';
WS : (' '){skip();};
EMPTY : '☛' '[' ']' '☚' '\n'{skip();}; 
ML_COMMENT : '/*' .+? '*/'{skip();};
