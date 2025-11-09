%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "ast.h"
int yylex(void);
void yyerror(char const *);

#define YYERROR_VERBOSE 1
#define YYDEBUG 1
%}
%union {
    int ival;
    float fval;
    char* text;
    int bval;
    void* exp;
    void* stm;
}
/* Non-terminals */
%type <exp> expr
%type <stm> stmt matched_stmt unmatched_stmt stmt_lst proc
/* Tokens */
%token PROCEDURE
%token MAIN
%token IS
%token BEGIN_TOKEN
%token END
%token PUT_LINE GET_LINE
%token <ival> NUM
%token <fval> REAL
%token <text> ID
%token <bval> TRUE
%token <bval> FALSE
%token LPAREN RPAREN
%token SEMICOLON
%token COLON
%token DOT
%token COMMA
%token ASSIGN
%token EQUAL_TO DIFFERENT_THAN
%token GREATER_THAN LESS_THAN
%token EQUAL_OR_GREATER EQUAL_OR_LESS
%token AND OR NOT XOR
%token PLUS MINUS
%token TIMES DIVISION
%token MOD POWER REM
%token IF THEN ELSE
%token WHILE LOOP
/* Operator precedence */
%left AND OR XOR
%left EQUAL_TO DIFFERENT_THAN LESS_THAN EQUAL_OR_LESS GREATER_THAN EQUAL_OR_GREATER
%left PLUS MINUS 
%left TIMES DIVISION MOD REM
%right NOT POWER
%start top
%%
top 
    : proc { root = $1; }
    ;
proc 
    : PROCEDURE MAIN IS BEGIN_TOKEN stmt_lst END MAIN SEMICOLON { $$ = mk_proced($5); }
    ;
stmt_lst 
    : stmt_lst stmt { $$ = mk_compound((Stm)$1, (Stm)$2); }
    | stmt          { $$ = $1; }
    | /* empty */   { $$ = NULL; }
    ;
stmt
    : matched_stmt
    | unmatched_stmt
    ;
/* Matched statements: completely closed structures */
matched_stmt
    : IF expr THEN matched_stmt ELSE matched_stmt END IF SEMICOLON { $$ = mk_if((Exp)$2, (Stm)$4, (Stm)$6); }
    | WHILE expr LOOP stmt_lst END LOOP SEMICOLON                  { $$ = mk_while((Exp)$2, (Stm)$4); }
    | ID ASSIGN expr SEMICOLON                                     { $$ = mk_assign($1, (Exp)$3); }
    ;
/* Unmatched statements: have dangling parts that can absorb an ELSE */
unmatched_stmt
    : IF expr THEN stmt END IF SEMICOLON                           { $$ = mk_if((Exp)$2, (Stm)$4, NULL); }
    | IF expr THEN matched_stmt ELSE unmatched_stmt END IF SEMICOLON { $$ = mk_if((Exp)$2, (Stm)$4, (Stm)$6); }
    ;
expr
    : NUM                         { $$ = mk_numexp($1); }
    | REAL                        { $$ = mk_floatexp($1); }
    | ID                          { $$ = mk_idexp($1); }
    | TRUE                        { $$ = mk_boolexp(1); }
    | FALSE                       { $$ = mk_boolexp(0); }
    | LPAREN expr RPAREN          { $$ = mk_parenexp((Exp)$2); }
    | expr EQUAL_TO expr          { $$ = mk_opexp((Exp)$1, OP_EQUAL_TO, (Exp)$3); }
    | expr DIFFERENT_THAN expr    { $$ = mk_opexp((Exp)$1, OP_DIFFERENT_THAN, (Exp)$3); }
    | expr GREATER_THAN expr      { $$ = mk_opexp((Exp)$1, OP_GREATER_THAN, (Exp)$3); }
    | expr LESS_THAN expr         { $$ = mk_opexp((Exp)$1, OP_LESS_THAN, (Exp)$3); }
    | expr EQUAL_OR_GREATER expr  { $$ = mk_opexp((Exp)$1, OP_EQUAL_OR_GREATER, (Exp)$3); }
    | expr EQUAL_OR_LESS expr     { $$ = mk_opexp((Exp)$1, OP_EQUAL_OR_LESS, (Exp)$3); }
    | expr AND expr               { $$ = mk_opexp((Exp)$1, OP_AND, (Exp)$3); }
    | expr OR expr                { $$ = mk_opexp((Exp)$1, OP_OR, (Exp)$3); }
    | expr XOR expr               { $$ = mk_opexp((Exp)$1, OP_XOR, (Exp)$3); }
    | NOT expr                    { $$ = mk_opexp(NULL, OP_NOT, (Exp)$2); }
    | expr PLUS expr              { $$ = mk_opexp((Exp)$1, OP_PLUS, (Exp)$3); }
    | expr MINUS expr             { $$ = mk_opexp((Exp)$1, OP_MINUS, (Exp)$3); }
    | expr TIMES expr             { $$ = mk_opexp((Exp)$1, OP_TIMES, (Exp)$3); }
    | expr DIVISION expr          { $$ = mk_opexp((Exp)$1, OP_DIVISION, (Exp)$3); }
    | expr MOD expr               { $$ = mk_opexp((Exp)$1, OP_MOD, (Exp)$3); }
    | expr REM expr               { $$ = mk_opexp((Exp)$1, OP_REM, (Exp)$3); }
    | expr POWER expr             { $$ = mk_opexp((Exp)$1, OP_POWER, (Exp)$3); }
    ;
%%
void yyerror(char const *msg) {
    printf("parse error: %s\n", msg);
    printf("Debug: Parser failed at token %d\n", yychar);
    exit(-1);
}
