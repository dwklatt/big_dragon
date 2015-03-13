#ifndef NODE_H
#define NODE_H
typedef struct node_s {
	char *name;
	int type;
	struct node_s *next;
} node_t;

node_t *make_node(char *name);
node_t *node_search(node_t *, char *);
node_t *node_insert(node_t *, char *);
#endif
