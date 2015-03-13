#ifndef SCOPE_H
#define SCOPE_H

#include "node.h"

#define HASH_SIZE	211
#define	EOS			'\0'

typedef struct scope_s {
	/* hash table: hashing with chaining */
	node_t *table[HASH_SIZE];

	struct scope_s *next;
}
scope_t;

/* constructor */
scope_t *make_scope();


/* local search and insert */
node_t *scope_search( scope_t *head, char *name );
node_t *scope_insert( scope_t *head, char *name );

node_t *scope_search_all( scope_t *head, char *name );

/* symbol table = stack of hash tables */
scope_t *scope_push(scope_t *);
scope_t *scope_pop(scope_t *);



#endif


