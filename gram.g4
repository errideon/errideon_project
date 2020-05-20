grammar MY;

//Основанна на грамматике pl0
//GRAMMAR

programm    	 :     block '.';

block       	 :     ((consts? vars?) | (vars? consts?)) procedure* statement ';'?;

vars        	 :     VAR IDENT ('=' (INTEGER | STRING | FLOAT | BOOL))? (',' IDENT ('=' (INTEGER | STRING | FLOAT | BOOL))?)* ';';
consts      	 :     CONST IDENT '=' (INTEGER | STRING | FLOAT | BOOL) (',' IDENT '=' (INTEGER | STRING | FLOAT | BOOL))* ';';
procedure 	 :     PROCEDURE IDENT ';' block;

statement   	 :     region | assign | call | print | ifst | whilest | breakst;

region    	 :     BEGIN statement  (';' statement)* ';'? END;
call      	 :     CALL IDENT;
assign     	 :     IDENT ASSIGN expr;
whilest    	 :     WHILE condition DO statement;
ifst       	 :     IF condition THEN statement;
print      	 :     PRINT '(' expression (',' expression)* ')';
breakst    	 :     BREAK;


condition  	 :     term_condition
                       | '(' condition ')'
                       | DENIAL condition
                       | condition AND term_condition;

term_condition   :     factor_cond
                       | DENIAL term_cond
                       | '(' term_cond ')'
                       | term_condition OR factor_condition;

factor_condition :     '(' expression COMPARE expression ')'
                       | '(' expression ')'
                       | DENIAL factor_condition;

expression  	 :     term
                       | expression ('+' | '-') term
                       | BOOL
                       | STRING;
term       	 :     factor
                       | term ('/' | '*') factor;
factor     	 :     IDENT | INTEGER | FLOAT | '(' expression ')';

//LEXER

BEGIN       :     B E G I N;
END         :     E N D;
VAR         :     V A R;
PROCEDURE   :     P R O C E D U R E;
WHILE       :     W H I L E;
DO          :     D O;
IF          :     I F;
THEN        :     T H E N;
ASSIGN      :     '=';
DENIAL      :     '!';
COMPARE     :     '==' | '>=' | '<='  | '>' | '<' | '!=';
CALL        :     C A L L;
CONST       :     C O N S T;
PRINT       :     P R I N T;
BREAK       :     B R E A K;
AND         :     A N D;
OR          :     O R;

fragment A  : ('a' | 'A');
fragment B  : ('b' | 'B');
fragment C  : ('c' | 'C');
fragment D  : ('d' | 'D');
fragment E  : ('e' | 'E');
fragment F  : ('f' | 'F');
fragment G  : ('g' | 'G');
fragment H  : ('h' | 'H');
fragment I  : ('i' | 'I');
fragment J  : ('j' | 'J');
fragment K  : ('k' | 'K');
fragment L  : ('l' | 'L');
fragment M  : ('m' | 'M');
fragment N  : ('n' | 'N');
fragment O  : ('o' | 'O');
fragment P  : ('p' | 'P');
fragment Q  : ('q' | 'Q');
fragment R  : ('r' | 'R');
fragment S  : ('s' | 'S');
fragment T  : ('t' | 'T');
fragment U  : ('u' | 'U');
fragment V  : ('v' | 'V');
fragment W  : ('w' | 'W');
fragment X  : ('x' | 'X');
fragment Y  : ('y' | 'Y');
fragment Z  : ('z' | 'Z');

BOOL        :     'true' | 'false';
IDENT       :     LETTERS(LETTERS|NUMBER)*;
FLOAT       :     '-'? NUMBER'.'NUMBER;
INTEGER     :     '-'? NUMBER;
STRING      :     '"' ~["\r]* '"';
NUMBER      :     [0-9]+;
LETTERS     :     [A-Za-z]+;
LONGCOMMENT :     '/*' .*? '*/' -> skip; 
COMMENT     :     '//' ~[\n\r]* -> skip; 
SPACE       :     [ \n\t\r]+ -> skip;
