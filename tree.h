#ifndef TREE_H
#define TREE_H

typedef struct tree_s {
	int type;		/* INUM, RNUM, ADDOP, MULOP, RELOP */
	union {
		int ival;	/* INUM */
		float rval;	/* RNUM */
		node_t *sval;	/* ID */
		int opval; 	/* ADDOP, MULOP, RELOP */
	} attribute;
	struct tree_s *left;
	struct tree_s *right;
}
tree_t;

/* constructor */
tree_t *make_tree(int type, tree_t *left, tree_t *right);
tree_t *make_op(int type, int attribute, tree_t *left, tree_t *right);
tree_t *make_id(node_t *node);
tree_t *make_inum(int ival);
tree_t *make_rnum(float rval);

void print_tree(tree_t *t, int spaces);

#endif
