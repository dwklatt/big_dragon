%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include "parser.tab.h"

  int _verbose = 0;

  void yyerror(char *msg)
  {
      fprintf(stderr, "Error: %s\n", msg);
        exit(1);
  }
  int yywrap(void)
  {
      return 1;
  }
  int main(int argc, char ** argv)
  {
      _verbose = (argc == 2) && !(strcmp(argv[1],"-v"));
        yyparse();
  }
%}

%token PROGRAM
%token ID
%token VAR
%token ARRAY
%token NUM
%token DOTDOT
%token OF
%token INT
%token REAL
%token FUNC
%token PROC
%token BEGGIN
%token END
%token IF
%token THEN
%token ELSE
%token WHILE
%token DO
%token RELOP
%token ADDOP
%token MULOP
%token ASSIGNOP
%token NOT

%%

program:
  PROGRAM ID '(' identifier_list ')' ';' declarations subprogram_declarations compound_statement '.'
  ;

identifier_list:
  ID
  | identifier_list ',' ID
  ;

declarations:
  declarations VAR identifier_list ':' type ';'
  |
  ;

type:
  standard_type
  | ARRAY '[' NUM DOTDOT NUM ']' OF standard_type
  ;

standard_type:
  INT
  | REAL
  ;

subprogram_declarations:
  subprogram_declarations subprogram_declaration ';'
  |
  ;

subprogram_declaration:
  subprogram_head declarations compound_statement
  ;

subprogram_head:
  FUNC ID arguments ':' standard_type ';'
  | PROC ID arguments ';'
  ;

arguments:
  '(' parameter_list ')'
  |
  ;

parameter_list:
  identifier_list ':' type
  | parameter_list ';' identifier_list ':' type
  ;

compound_statement:
   BEGGIN optional_statements END
  ;

optional_statements:
  statement_list
  |
  ;

statement_list:
  statement
  | statement_list ';' statement
  ;

statement:
  variable ASSIGNOP expression
  | procedure_statement
  | compound_statement
  | IF expression THEN statement ELSE statement
  | WHILE expression DO statement
  ;

variable:
  ID
  | ID '[' expression ']'
  ;

procedure_statement:
  ID
  | ID '(' expression_list ')'
  ;

expression_list:
  expression
  | expression_list ',' expression
  ;

expression:
  simple_expression
  | simple_expression RELOP simple_expression
  ;

simple_expression:
  term
  | sign term
  | simple_expression ADDOP term
  ;

term:
  factor
  | term MULOP factor
  ;

factor:
  ID
  | ID '(' expression_list ')'
  | NUM
  | '(' expression ')'
  | NOT factor
  ;

sign:
  '+'
  | '-'
  ;

%%
