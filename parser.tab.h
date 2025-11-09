/* A Bison parser, made by GNU Bison 3.8.2.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2021 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <https://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* DO NOT RELY ON FEATURES THAT ARE NOT DOCUMENTED in the manual,
   especially those whose name start with YY_ or yy_.  They are
   private implementation details that can be changed or removed.  */

#ifndef YY_YY_PARSER_TAB_H_INCLUDED
# define YY_YY_PARSER_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token kinds.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    YYEMPTY = -2,
    YYEOF = 0,                     /* "end of file"  */
    YYerror = 256,                 /* error  */
    YYUNDEF = 257,                 /* "invalid token"  */
    PROCEDURE = 258,               /* PROCEDURE  */
    MAIN = 259,                    /* MAIN  */
    IS = 260,                      /* IS  */
    BEGIN_TOKEN = 261,             /* BEGIN_TOKEN  */
    END = 262,                     /* END  */
    PUT_LINE = 263,                /* PUT_LINE  */
    GET_LINE = 264,                /* GET_LINE  */
    NUM = 265,                     /* NUM  */
    REAL = 266,                    /* REAL  */
    ID = 267,                      /* ID  */
    TRUE = 268,                    /* TRUE  */
    FALSE = 269,                   /* FALSE  */
    LPAREN = 270,                  /* LPAREN  */
    RPAREN = 271,                  /* RPAREN  */
    SEMICOLON = 272,               /* SEMICOLON  */
    COLON = 273,                   /* COLON  */
    DOT = 274,                     /* DOT  */
    COMMA = 275,                   /* COMMA  */
    ASSIGN = 276,                  /* ASSIGN  */
    EQUAL_TO = 277,                /* EQUAL_TO  */
    DIFFERENT_THAN = 278,          /* DIFFERENT_THAN  */
    GREATER_THAN = 279,            /* GREATER_THAN  */
    LESS_THAN = 280,               /* LESS_THAN  */
    EQUAL_OR_GREATER = 281,        /* EQUAL_OR_GREATER  */
    EQUAL_OR_LESS = 282,           /* EQUAL_OR_LESS  */
    AND = 283,                     /* AND  */
    OR = 284,                      /* OR  */
    NOT = 285,                     /* NOT  */
    XOR = 286,                     /* XOR  */
    PLUS = 287,                    /* PLUS  */
    MINUS = 288,                   /* MINUS  */
    TIMES = 289,                   /* TIMES  */
    DIVISION = 290,                /* DIVISION  */
    MOD = 291,                     /* MOD  */
    POWER = 292,                   /* POWER  */
    REM = 293,                     /* REM  */
    IF = 294,                      /* IF  */
    THEN = 295,                    /* THEN  */
    ELSE = 296,                    /* ELSE  */
    WHILE = 297,                   /* WHILE  */
    LOOP = 298                     /* LOOP  */
  };
  typedef enum yytokentype yytoken_kind_t;
#endif

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
union YYSTYPE
{
#line 12 "parser.y"

    int ival;
    float fval;
    char* text;
    int bval;
    void* exp;
    void* stm;

#line 116 "parser.tab.h"

};
typedef union YYSTYPE YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;


int yyparse (void);


#endif /* !YY_YY_PARSER_TAB_H_INCLUDED  */
