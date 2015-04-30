#include <stdio.h>
#include <stdlib.h>
#include <assert.h>
#include <string.h>
#include "node.h"
#include "tree.h"
#include "parser.tab.h"

/* constructors */
tree_t *make_tree(int type, tree_t *left, tree_t *right)
{
	tree_t *p = (tree_t *)malloc(sizeof(tree_t));
	assert(p != NULL);

	p->type = type;
	p->left = left;
	p->right = right;

	return p;
}

tree_t *make_op(int type, int attribute, tree_t *left, tree_t *right)
{
	tree_t *p = make_tree(type, left, right);
	p->attribute.opval = attribute;
	return p;
}

tree_t *make_inum(int val)
{
	//tree_t *p = make_tree(INUM, NULL, NULL);
  tree_t *p = (tree_t *)malloc(sizeof(tree_t));
  assert( p != NULL );
  p->type = INUM;
	p->attribute.ival = val;
  p->left = NULL;
  p->right = NULL;
	return p;
}

tree_t *make_rnum(float val)
{
	//tree_t *p = make_tree(RNUM, NULL, NULL);
  tree_t *p = (tree_t *)malloc(sizeof(tree_t));
  assert( p != NULL );
  p->type = RNUM;
	p->attribute.rval = val;
  p->left = NULL;
  p->right = NULL;
	return p;
}

tree_t *make_id(node_t *node)
{
	//tree_t *p = make_tree(ID, NULL, NULL);
  tree_t *p = (tree_t *)malloc(sizeof(tree_t));
  assert( p != NULL );
  p->type = ID;
	p->attribute.sval = node;
  p->left = NULL;
  p->right = NULL;
	return p;
}

void make_type(tree_t * t, int type)
{
	if (t->type == ID) {
		t->attribute.sval->type = type;
		return;
	}
	make_type(t->left, type);
	make_type(t->right, type);
}

/* preorder */
void print_tree(tree_t *t, int spaces)
{
	int i;

	if (t == NULL)
		return;

	for (i=0; i<spaces; i++) {
		fprintf(stderr, " ");
	}

	/* process root */
	switch(t->type) {
	case ID:
		fprintf(stderr, "[ID:%s]", (t->attribute.sval)->name);
		break;
	case INUM:
		fprintf(stderr, "[INUM:%d]", t->attribute.ival);
		break;
	case RNUM:
		fprintf(stderr, "[RNUM:%f]", t->attribute.rval);
		break;
	case ADDOP:
		fprintf(stderr, "[ADDOP:%d]", t->attribute.opval);
		break;
	case MULOP:
		fprintf(stderr, "[MULOP:%d]", t->attribute.opval);
		break;
	case RELOP:
		fprintf(stderr, "[RELOP:%d]", t->attribute.opval);
		break;
	case ASSIGNOP:
		fprintf(stderr, "[ASSIGNOP:%d]", t->attribute.opval);
		break;
	default:
		fprintf(stderr, "[UNKNOWN]");
		break;
	}
	fprintf(stderr, "\n");

	/* go left */
	if(t->left != NULL) {
		print_tree(t->left, spaces+4);
	}
	/* go right */
	if(t->right != NULL) {
		print_tree(t->right, spaces+4);
	}

}

int find_type(tree_t *t){
	int left,right;
	if( t == NULL) { return 0; }
	if(t->type == INUM){ return INUM; }
	else if(t->type == RNUM){ return RNUM; }
	else if(t->type == ID){ return t->attribute.sval->type; }
	else if(t->type == RELOP){ return RELOP; }
	else if(t->type == ADDOP || t->type == MULOP) {
		left = find_type(t->left);
		right = find_type(t->right);
		if(left != right) { return 0; }
		else { return left; }
	}
	else { return 0; }
}

int semantic_check(tree_t *t) {
	assert(t != NULL);
	int left, right;
	left = find_type(t->left);
	right = find_type(t->right);
	switch(t->type) {
		case ADDOP:
			if(!left || !right){ 
				fprintf(stderr, "incomplete statement?\n"); 
				return -1; 
			}
			if(left != right) {
				fprintf(stderr, "you can't add a %d to a %d", left, right);
				return -1; 
			}
			return 0;
		case MULOP:
			if(!left || !right){ 
				fprintf(stderr, "incomplete statement?\n"); 
				return -1; 
			}
			return 0;
		case ASSIGNOP:
			if(!left || !right){ 
				fprintf(stderr, "incomplete statement?\n"); 
				return -1; 
			}
			if(left != right) {
				fprintf(stderr, "this isn't python, a %s cannot have a value of %s\n", left, right);
				return -1;
			}
			return 0;
		case RELOP:
			if(left != 276) {
				fprintf(stderr, "not a boolean statement\n");
				return -1;
			}
			//fprintf(stderr,"made it to RELOP, %d %d\n", left, t->left->attribute.opval);
			return 0;
		case INUM:
			return 0;
		case RNUM:
			return 0;
		case ID:
			return 0;
		default:
			fprintf(stderr, "Unknown operation, bailing... [%d]\n",t->type); 
			return -1;
	}

}
