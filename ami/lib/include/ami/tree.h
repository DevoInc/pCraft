#ifndef _AMI_TREE_H_
#define _AMI_TREE_H_

enum _ami_node_type_t {
       AMI_NT_NONE,
       AMI_NT_VERSION,
       AMI_NT_REVISION,
       AMI_NT_AUTHOR,
       AMI_NT_SHORTDESC,
       AMI_NT_REFERENCE,
       AMI_NT_TAG,
       AMI_NT_REPEAT,
       AMI_NT_IF_ELSE,
       AMI_NT_LABEL,     // label:
       AMI_NT_GOTO,      // goto label:
       AMI_NT_LOCALVARNAME, // _var
       AMI_NT_VARNAME, // $var
       AMI_NT_VARVALSTR, // = "blah"
       AMI_NT_VARVALINT, // = 1
       AMI_NT_VARVAR,    // = $var
       AMI_NT_REPLACE,   // foo => blah
       AMI_NT_ACTION,    // action Foo {
       AMI_NT_ACTIONCLOSE, // } for an action
       AMI_NT_MESSAGE,   // message "Hello"
       AMI_NT_FUNCTION,  // csv("a", "b", ..)
       AMI_NT_FUNCARG,   // "a"
       AMI_NT_EXEC,      // exec Foo
       AMI_NT_FIELDOP,   // field["ip"]
       AMI_NT_FIELDFUNC, // field["ip"].replace()
       AMI_NT_FIELDVAR,  // field["foo"] = ...
       AMI_NT_EXIT,
       AMI_NT_SLEEP,
       AMI_NT_ARRAYVAR, // $var = []
       AMI_NT_ARRAYGET, // $var[1]
};
typedef enum _ami_node_type_t ami_node_type_t;

struct _ami_node_t {
  ami_node_type_t type;
  char *strval;
  int is_verbatim;
  int   intval;
  float fval;
  struct _ami_node_t *left;  
  struct _ami_node_t *right;
  struct _ami_node_t *next;
  
};
typedef struct _ami_node_t ami_node_t;

struct _ami_tree_node_t {
  ami_node_type_t type;
  size_t size;
  char *strval;
  int   intval;
  struct _ami_tree_node_t *next;
};
typedef struct _ami_tree_node_t ami_tree_node_t;

struct _ami_tree_t {
  struct _ami_tree_t *root;
  struct _ami_tree_node_t *leaves;
  struct _ami_tree_t *next;
};
typedef struct _ami_tree_t ami_tree_t;

static const char *ami_node_names[] = {
       "AMI_NT_NONE",
       "AMI_NT_VERSION",
       "AMI_NT_REVISION",
       "AMI_NT_AUTHOR",
       "AMI_NT_SHORTDESC",
       "AMI_NT_REFERENCE",
       "AMI_NT_TAG",
       "AMI_NT_REPEAT",
       "AMI_NT_IF_ELSE",
       "AMI_NT_LABEL",
       "AMI_NT_GOTO",
       "AMI_NT_VARNAME",
       "AMI_NT_VARVALSTR",
       "AMI_NT_VARVALINT",
       "AMI_NT_VARVAR",
       "AMI_NT_REPLACE",
       "AMI_NT_ACTION",
       "AMI_NT_ACTIONCLOSE",
       "AMI_NT_MESSAGE",
       "AMI_NT_FUNCTION",
       "AMI_NO_FUNCARG",
       "AMI_NT_EXEC",
       "AMI_NO_FIELDOP",
       "AMI_NT_FIELDFUNC",
       "AMI_NT_FIELDVAR",
       "AMI_NT_EXIT",
       "AMI_NT_SLEEP"
};

ami_tree_t *ami_tree_new(void);
void ami_tree_close(ami_tree_t *tree);
ami_tree_node_t *ami_tree_node_new(void);
void ami_tree_node_close(ami_tree_node_t *tree);
int ami_tree_node_append(ami_tree_node_t *dstnode, ami_tree_node_t *srcnode);
int ami_tree_node_debug(ami_tree_node_t *node);
int ami_tree_debug(ami_tree_t *tree);
int ami_tree_attach_leaf(ami_tree_t *tree, ami_tree_node_t *leaf);
int ami_tree_copy_leaves(ami_tree_t *tree, ami_tree_node_t *leaves);
int ami_tree_append(ami_tree_t *dsttree, ami_tree_t *srctree);
void ami_tree_append_int_no_leaves(ami_tree_t *tree, ami_node_type_t type, int val);
void ami_tree_append_str_no_leaves(ami_tree_t *tree, ami_node_type_t type, char *val);

ami_node_t *ami_node_new(void);
void ami_node_debug(ami_node_t *node);
ami_node_t *ami_node_prepend(ami_node_t *nodedst, ami_node_t *nodesrc);
ami_node_t *ami_node_append(ami_node_t *nodedst, ami_node_t *nodesrc);
ami_node_t *ami_node_append_right(ami_node_t *nodedst, ami_node_t *nodesrc);
void ami_node_create(ami_node_t **root, ami_node_type_t type, char *strval, int intval, float fval, int is_verbatim_string);
void ami_node_create_right(ami_node_t **root, ami_node_type_t type, char *strval, int intval, float fval, int is_verbatim_string);

#endif // _AMI_TREE_H_
