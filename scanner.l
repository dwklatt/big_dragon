%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <assert.h>
	#include "node.h"
	#include "scope.h"
	#include "tree.h"
  #include "parser.tab.h"

  //convient macro from ethan
  #define PRINTA(x)   fprintf(stderr, "{%s}", #x); return x
  #define PRINTB(x)  fprintf(stderr, "{%s[%s]}", #x, yytext); return x

%}

whitespace  [ \t]+
comment 		\(\*.*\*\)
letter      [a-zA-Z]
digit       [0-9]
id          {letter}({letter}|{digit})*
num					{digit}+

%%

"="   { yylval.opval = EQ; PRINTB(RELOP); }
"<"   { yylval.opval = LT; PRINTB(RELOP); }
"<>"  { yylval.opval = NE; PRINTB(RELOP); }
"<="  { yylval.opval = LE; PRINTB(RELOP); }
">="  { yylval.opval = GE; PRINTB(RELOP); }
">"   { yylval.opval = GT; PRINTB(RELOP); }

"+"   { yylval.opval = PLUS; PRINTB(ADDOP); }
"-"   { yylval.opval = MINUS; PRINTB(ADDOP); }
"or"  { yylval.opval = OR; PRINTB(ADDOP); }

"*"   { yylval.opval = STAR; PRINTB(MULOP); }
"/"   { yylval.opval = SLASH; PRINTB(MULOP); }
"div" { yylval.opval = DIV; PRINTB(MULOP); }
"mod" { yylval.opval = MOD; PRINTB(MULOP); }
"and" { yylval.opval = AND; PRINTB(MULOP); }

":="  { PRINTA(ASSIGNOP); }
"("   { PRINTA(LP); }
")"   { PRINTA(RP); }
"["   { PRINTA(LBRKT); }
"]"   { PRINTA(RBRKT); }
","   { PRINTA(COMMA); }
":"   { PRINTA(COLON); }
";"   { PRINTA(SEMI); }
"."   { PRINTA(DOT); }


"program"   { PRINTA(PROGRAM); }
"var"       { PRINTA(VAR); }
"array"     { PRINTA(ARRAY); }
".."        { PRINTA(DOTDOT); }
"of"        { PRINTA(OF); }
"integer"   { PRINTA(INT); }
"real"      { PRINTA(REAL); }
"function"  { PRINTA(FUNC); }
"procedure" { PRINTA(PROC); }
"begin"     { PRINTA(BEGGIN); }
"end"       { PRINTA(END); }
"if"        { PRINTA(IF); }
"then"      { PRINTA(THEN); }
"else"      { PRINTA(ELSE); }
"while"     { PRINTA(WHILE); }
"do"        { PRINTA(DO); }
"not"       { PRINTA(NOT); }

{num}       	{ yylval.ival = atoi(yytext); PRINTB(INUM); }
{num}'.'{num}	{ yylval.rval = atof(yytext); PRINTB(RNUM); }
{id}        	{ yylval.sval = strdup(yytext); PRINTB(ID); }

{whitespace} { ; }
{comment} { ; }

\n  { fprintf(stderr, "%s", yytext); }
.   { fprintf(stderr, "<%c>", yytext[0]); return yytext[0]; }

%%
