#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "node.h"
node_t *make_node(char *name)
{
	node_t *p = (node_t *)malloc(sizeof(node_t));
	p->name = strdup(name);
	return p;
}
node_t *node_search(node_t *head, char *name)
{
	node_t *p = head;
	while (p != NULL) {
		if (!strcmp(p->name, name)) {
			return p;
		}
		p = p->next;
	}
	return NULL;
}
node_t *node_insert(node_t *head, char *name)
{
	node_t *p = make_node(name);
	p->next = head;
	return p;
}