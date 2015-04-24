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
letter      [a-zA-Z]
digit       [0-9]
id          {letter}({letter}|{digit})*
num					{digit}+

%%

"="   { PRINTB(RELOP); }
"<"   { PRINTB(RELOP); }
"<>"  { PRINTB(RELOP); }
"<="  { PRINTB(RELOP); }
">="  { PRINTB(RELOP); }
">"   { PRINTB(RELOP); }

"+"   { PRINTB(ADDOP); }
"-"   { PRINTB(ADDOP); }
"or"  { PRINTB(ADDOP); }

"*"   { PRINTB(MULOP); }
"/"   { PRINTB(MULOP); }
"div" { PRINTB(MULOP); }
"mod" { PRINTB(MULOP); }
"and" { PRINTB(MULOP); }

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

{num}       	{ PRINTB(INUM); }
{num}'.'{num}	{ PRINTB(RNUM); }
{id}        	{ PRINTA(ID); }

{whitespace} { ; }
\n  { fprintf(stderr, "%s", yytext); }
.   { fprintf(stderr, "<%c>", yytext[0]); return yytext[0]; }

%%
