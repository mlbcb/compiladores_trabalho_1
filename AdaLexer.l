%{
#include "parser.tab.h"
#include <string.h>
#include <stdio.h>
%}
/* %option caseless */

%%

"--".*                               { /* Comment */ }
[ \t\r]+                             { /* Skip whitespace */ }
\n                                   { /* Skip newline */ }

[0-9]+\.[0-9]+ { 
    yylval.fval = atof(yytext);
    return REAL;
}

[0-9]+ { 
    yylval.ival = atoi(yytext);
    printf("TOKEN: NUM=%s (%d)\n", yytext, yylval.ival);
    return NUM;
}

[A-Za-z][A-Za-z0-9_]* {
    // Primeiro, verificar para literais booleanos
    if (strcmp(yytext, "true") == 0)  { yylval.bval = 1; return TRUE; }
    if (strcmp(yytext, "false") == 0) { yylval.bval = 0; return FALSE; }

    // Depois, para as outras palavras reservadas
    if (strcmp(yytext, "procedure") == 0) { printf("TOKEN: PROCEDURE\n"); return PROCEDURE; }
    if (strcmp(yytext, "Main") == 0) { printf("TOKEN: MAIN\n"); return MAIN; }
    if (strcmp(yytext, "is") == 0) { printf("TOKEN: IS\n"); return IS; }
    if (strcmp(yytext, "begin") == 0) { printf("TOKEN: BEGIN_TOKEN\n"); return BEGIN_TOKEN; }
    if (strcmp(yytext, "end") == 0) { printf("TOKEN: END\n"); return END; }
    if (strcmp(yytext, "if") == 0) return IF;
    if (strcmp(yytext, "then") == 0) return THEN;
    if (strcmp(yytext, "else") == 0) return ELSE;
    if (strcmp(yytext, "while") == 0) return WHILE;
    if (strcmp(yytext, "loop") == 0) return LOOP;
    if (strcmp(yytext, "Put_Line") == 0) return PUT_LINE;
    if (strcmp(yytext, "Get_Line") == 0) return GET_LINE;
    if (strcmp(yytext, "and") == 0) return AND;
    if (strcmp(yytext, "or") == 0) return OR;
    if (strcmp(yytext, "not") == 0) return NOT;
    if (strcmp(yytext, "xor") == 0) return XOR;
    if (strcmp(yytext, "mod") == 0) return MOD;
    if (strcmp(yytext, "rem") == 0) return REM;

    // Caso contrário, é um identificador
    yylval.text = strdup(yytext);
    printf("TOKEN: ID=%s\n", yytext);
    return ID;
}

":="                                 { printf("TOKEN: ASSIGN\n"); return ASSIGN; }
"="                                  { return EQUAL_TO; }
"/="                                 { return DIFFERENT_THAN; }
"<="                                 { return EQUAL_OR_LESS; }
">="                                 { return EQUAL_OR_GREATER; }
"<"                                  { return LESS_THAN; }
">"                                  { return GREATER_THAN; }
"+"                                  { return PLUS; }
"*"                                  { return TIMES; }
"/"                                  { return DIVISION; }
"("                                  { return LPAREN; }
")"                                  { return RPAREN; }
";"                                  { printf("TOKEN: SEMICOLON\n"); return SEMICOLON; }
":"                                  { return COLON; }
[.]                                  { return DOT; }
","                                  { return COMMA; }
"-"                                  { return MINUS; }
"**"                                  { return POWER; }

.                                    { printf("UNKNOWN: %s\n", yytext); }

<<EOF>>                               { return 0; }  /* End-of-file token */

%%

int yywrap(void) { return 1; }

/* yyerror is defined in parser.y */
