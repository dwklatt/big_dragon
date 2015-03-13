%{
  #include <stdio.h>
  #include <stdlib.h>
  #include <string.h>
  #include <assert.h>
	#include "node.h"
	#include "scope.h"
	#include "tree.h"
  #include "parser.tab.h"
  
  extern scope_t *top_scope;
	extern node_t *tmp;
  
%}

%union {
	int ival;
	float rval;
	char *sval;
	int opval;
	tree_t *tval;
}

%token PROGRAM
%token <sval> ID
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
%token <opval> RELOP
%token <opval> ADDOP
%token <opval> MULOP
%token ASSIGNOP
%token NOT

%token <ival> INUM
%token <rval> RNUM

%token LT LE GT GE EQ NE
%token OR PLUS MINUS
%token AND STAR SLASH

%token FUNCTION_CALL
%token ARRAY_ACCESS
%token COMMA

%type <tval> expression_list
%type <tval> expression
%type <tval> simple_expression
%type <tval> term
%type <tval> factor

%%

program:
	{ top_scope = scope_push(top_scope); }
  PROGRAM ID '(' identifier_list ')' ';' declarations subprogram_declarations compound_statement '.'
  { top_scope = scope_pop(top_scope); }
  ;

identifier_list:
  ID { scope_insert(top_scope, $1); }
  | identifier_list ',' ID { scope_insert(top_scope, $3); }
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
  { top_scope = scope_pop(top_scope); }
  ;

subprogram_head:
  FUNC ID { top_scope = scope_push(top_scope); }
  arguments ':' standard_type ';'
  | PROC ID { top_scope = scope_push(top_scope); }
  arguments ';'
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
  { fprintf(stderr, "\n\nPRINTING TREE:\n");
		print_tree($3,0);
		fprintf(stderr, "\n\n");
	}
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
  simple_expression { $$ = $1; }
  | simple_expression RELOP simple_expression
  { $$ = make_op(RELOP, $2, $1, $3); }
  ;

simple_expression:
  term { $$ = $1; }
  | simple_expression ADDOP term
  { $$ = make_op(ADDOP, $2, $1, $3); }
  ;

term:
  factor { $$ = $1; }
  | term MULOP factor
  { $$ = make_op(MULOP, $2, $1, $3); }
  ;

factor:
  ID
  {
		if ((tmp = scope_search_all(top_scope, $1)) == NULL) {
			fprintf(stderr, "Name %s used but not defined\n", $1);
			exit(1);
		}
		$$ = make_id(tmp);
	}
  | ID '[' expression ']'
  {
		if ((tmp = scope_search_all(top_scope, $1)) == NULL) {
			fprintf(stderr, "Name %s used but not defined\n", $1);
			exit(1);
		}
		$$ = make_tree(ARRAY_ACCESS, make_id(tmp), $3);
	}
  | ID '(' expression_list ')'
	{
		if ((tmp = scope_search_all(top_scope, $1)) == NULL) {
			fprintf(stderr, "Name %s used but not defined\n", $1);
			exit(1);
		}
		$$ = make_tree(FUNCTION_CALL, make_id(tmp), $3);
	}
	| INUM { $$ = make_inum($1); }
	| RNUM { $$ = make_rnum($1); }
  | '(' expression ')' { $$ = $2; }
  | NOT factor { $$ = make_tree(NOT,NULL,NULL); }
  ;

/*
sign:
  '+'
  | '-'
  ;
*/

%%

scope_t *top_scope;
node_t *tmp;
main()
{
	top_scope = NULL;
	tmp = NULL;
	yyparse();
}
yyerror(char *message)
{
	fprintf(stderr, "Error: %s\n", message);
	exit(1);
}
