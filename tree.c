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
	default:
		fprintf(stderr, "[UNKNOWN]");
		break;
	}
	fprintf(stderr, "\n");

	/* go left */
	print_tree(t->left, spaces+4);
	/* go right */
	print_tree(t->right, spaces+4);

}


