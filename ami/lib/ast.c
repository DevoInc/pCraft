#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>

#include <sys/stat.h>
#include <sys/types.h>

#include <sys/socket.h> 
#include <netinet/in.h>
#include <arpa/inet.h>

#include <ami/kvec.h>
#include <ami/ami.h>
#include <ami/action.h>
#include <ami/tree.h>
#include <ami/ast.h>
#include <ami/csvread.h>
#include <ami/base64.h>
#include <ami/rc4.h>
#include <ami/strutil.h>

#include <uuid/uuid.h>

#include <md5.h>
#include <sha1.h>
#include <sha256.h>

static char *_replace_strval_from_variables(ami_t *ami, char *strval) {
  char *replaced_buf = NULL;
  char *found;
  khint_t k;

  replaced_buf = strdup(strval);
  
  if (ami->local_variables) {
    for (k = 0; k < kh_end(ami->local_variables); ++k) {
      if (kh_exist(ami->local_variables, k)) {
	char *key = (char *)kh_key(ami->local_variables, k);
	char *value = (char *)kh_value(ami->local_variables, k);
	char *replacevar = ami_strutil_make_replacevar(key);
	found = strstr(replaced_buf, replacevar);
	if (found) {
	  char *new_replaced_buf = ami_strutil_replace_all_substrings(replaced_buf, replacevar, value);
	  free(replaced_buf);
	  replaced_buf = new_replaced_buf;
	}
	free(replacevar);
      }
    }
  }

  if (ami->repeat_variables) {
    for (k = 0; k < kh_end(ami->repeat_variables); ++k) {
      if (kh_exist(ami->repeat_variables, k)) {
	char *key = (char *)kh_key(ami->repeat_variables, k);
	char *value = (char *)kh_value(ami->repeat_variables, k);
	char *replacevar = ami_strutil_make_replacevar(key);
	found = strstr(replaced_buf, replacevar);
	if (found) {
	  char *new_replaced_buf = ami_strutil_replace_all_substrings(replaced_buf, replacevar, value);
	  free(replaced_buf);
	  replaced_buf = new_replaced_buf;
	}
	free(replacevar);
      }
    }
  }

  if (ami->global_variables) {
    for (k = 0; k < kh_end(ami->global_variables); ++k) {
      if (kh_exist(ami->global_variables, k)) {
	char *key = (char *)kh_key(ami->global_variables, k);
	char *value = (char *)kh_value(ami->global_variables, k);
	char *replacevar = ami_strutil_make_replacevar(key);
	found = strstr(replaced_buf, replacevar);
	if (found) {
	  char *new_replaced_buf = ami_strutil_replace_all_substrings(replaced_buf, replacevar, value);
	  free(replaced_buf);
	  replaced_buf = new_replaced_buf;
	}
	free(replacevar);
      }
    }
  }

  return replaced_buf;
}

static void walk_node(ami_t *ami, ami_node_t *node, int repeat_index, int right)
{
  ami_node_t *n;
  ami_action_t *action;
  int index;
  char *stack_str = NULL; // Keeping the last value
  int stack_int = 0;
  char *tmp_str;
  /* static char *csv_args[4] = { NULL, NULL, NULL, NULL }; // For now, we only have the CSV function */
  kvec_t(char *) values_stack;
  static int varpos = 0;  
  ami_field_action_t *field_action;
  char *replaced_var = NULL;
  
  for (n = node; n; n = right ? n->right : n->next) {

    if ((n->strval) && (!n->is_verbatim)) {
      if (n->type == AMI_NT_VARVALSTR) {
	replaced_var = _replace_strval_from_variables(ami, n->strval);
      }
    }
    
    switch(n->type) {
    case AMI_NT_REFERENCE:
      kv_push(char *, ami->references, n->strval);      
      break;
    case AMI_NT_TAG:
      kv_push(char *, ami->tags, n->strval);      
      break;
    case AMI_NT_ACTION:
      ami->in_action = 1;
      action = ami_action_new();
      if (!action) {
	fprintf(stderr, "Error creating the action!\n");
      }
      action->name = n->strval;
      break;
    case AMI_NT_EXEC:
      action->exec = n->strval;      
      break;
    case AMI_NT_ACTIONCLOSE:
      ami->in_action = 0;

      /* ami_field_action_debug(action); */
      if (right) {
	action->repeat_index = repeat_index;
      }
      action->sleep_cursor = ami->sleep_cursor;
      action = ami_action_copy_variables(ami, action);
      if (ami->action_cb) {
	ami->action_cb(action, ami->action_cb_userdata);
      } else {
	fprintf(stderr,"*** Warning: No Action Callback Set!\n");
      }
      ami_action_close(action);
      /* ami_erase_local_variables(ami); */
      break;
    case AMI_NT_REPEAT:
      ami->in_repeat = 1;
      for (index = 1; index <= n->intval; index++) {
	char *indexvar;
	asprintf(&indexvar, "%d", index);
	ami_set_global_variable(ami, n->strval, indexvar);
	/* printf("We run a repeat action at index:%d\n", index); */
      	walk_node(ami, n->right, index, 1);
      }
      ami_erase_repeat_variables(ami);
      ami->in_repeat = 0;
      index = 0;
      break;
    case AMI_NT_MESSAGE:
      printf("%s\n", n->strval);
      break;
    case AMI_NT_VARVALSTR:
      if (replaced_var) {
	kv_push(char *, ami->values_stack, replaced_var);
      } else {
	kv_push(char *, ami->values_stack, n->strval);
      }
      break;
    case AMI_NT_VARVALINT:
      asprintf(&tmp_str, "%d", n->intval);
      kv_push(char *, ami->values_stack, strdup(tmp_str));
      free(tmp_str);
      /* kv_a(char *, ami->values_stack, strdup(n->strval)); */
      break;
    case AMI_NT_VARVAR:
      kv_push(char *, ami->values_stack, strdup(n->strval));            
      break;
    case AMI_NT_VARNAME:
      tmp_str = kv_A(ami->values_stack, kv_size(ami->values_stack)-1);
      if (ami->in_repeat || ami->in_action) {
	if (!ami->in_action) {
	  /* printf("%s is a local repeat variable with value:%s\n", n->strval, kv_A(ami->values_stack, kv_size(ami->values_stack)-1)); */
	  ami_set_repeat_variable(ami, n->strval, tmp_str);
	} else {
	  /* printf("%s is a local action variable with value:%s\n", n->strval, kv_A(ami->values_stack, kv_size(ami->values_stack)-1)); */
	  ami_set_local_variable(ami, n->strval, tmp_str);
	}
      } else {
	/* printf("%s is a global variable with value:%s\n", n->strval, kv_A(ami->values_stack, kv_size(ami->values_stack)-1)); */
	  ami_set_global_variable(ami, n->strval, tmp_str);
      }
      break;
    case AMI_NT_FIELDFUNC:
      /* printf("Fieldfunc :%s\n", n->strval); // ip */
      if (!strcmp("replace", kv_A(ami->values_stack, kv_size(ami->values_stack)-1))) {
	size_t stacklen = kv_size(ami->values_stack);
	/* printf("the stacklen when we replace:%ld\n", stacklen); */
	/* for (size_t i = 0; i < stacklen; i++) { */
	/*   printf("i:%d;val:%s\n", i, kv_A(ami->values_stack, i)); */
	/* } */

	for (int i = 1; i <= ami->replace_count; i++) {
	  int pos_from = (i*-1)-i; 
	  int pos_to = (i*-1)-(i+1);
	  char *to = kv_A(ami->values_stack, stacklen+pos_to);
	  char *from = kv_A(ami->values_stack, stacklen+pos_from);
	  
	  field_action = ami_field_action_new();
	  field_action->field = n->strval;
	  field_action->action = "replace";
	  field_action->left = ami_get_variable(ami, from);
	  field_action->right = ami_get_variable(ami, to);
	  action->field_actions = ami_field_action_append(action->field_actions, field_action);
	  
	}
	ami->replace_count = 0;
      } else {
	fprintf(stderr, "Unknown function call on field %s: %s\n", n->strval, kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	exit(1);
      }
      
      break;
    case AMI_NT_FIELDVAR:
      /* printf("Fieldvar :%s\n", n->strval); // FullFilePath */
      field_action = ami_field_action_new();
      field_action->field = n->strval;
      field_action->action = "set";
      char *value = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
      field_action->right = value;

      if (!action) {
	fprintf(stderr, "No Action created!\n");
      } else {
	action->field_actions = ami_field_action_append(action->field_actions, field_action);
      }
      break;
    case AMI_NT_REPLACE:
      {
	/* ami_print_all_variables(ami); */
	/* char *replace_with = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-1)); */
	/* printf("replace:%s with:%s\n", n->strval, replace_with); */
	kv_push(char *, ami->values_stack, strdup(n->strval));
	ami->replace_count++;
      }
      break;
    case AMI_NT_FUNCTION:
      if (!strcmp("base64.encode", n->strval)) {
	char *data = kv_A(ami->values_stack, kv_size(ami->values_stack)-1);
	char *b64 = base64_enc_malloc(data, strlen(data));
	kv_push(char *, ami->values_stack, b64);	
      } else if (!strcmp("crypto.md5", n->strval)) {
	const char *strbuf = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	MD5_CTX ctx;
	unsigned char buf[16];
	
	md5_init(&ctx);
	md5_update(&ctx, strbuf, strlen(strbuf));
	md5_final(&ctx, buf);

	char *hex = ami_rc4_to_hex(buf, 16);	
	kv_push(char *, ami->values_stack, hex);
      } else if (!strcmp("crypto.sha1", n->strval)) {
	const char *strbuf = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	SHA1_CTX ctx;
	unsigned char buf[SHA1_BLOCK_SIZE];
	
	sha1_init(&ctx);
	sha1_update(&ctx, strbuf, strlen(strbuf));
	sha1_final(&ctx, buf);

	char *hex = ami_rc4_to_hex(buf, SHA1_BLOCK_SIZE);	
	kv_push(char *, ami->values_stack, hex);
      } else if (!strcmp("crypto.sha256", n->strval)) {
	const char *strbuf = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	SHA256_CTX ctx;
	unsigned char buf[SHA256_BLOCK_SIZE];
	
	sha256_init(&ctx);
	sha256_update(&ctx, strbuf, strlen(strbuf));
	sha256_final(&ctx, buf);

	char *hex = ami_rc4_to_hex(buf, SHA256_BLOCK_SIZE);	
	kv_push(char *, ami->values_stack, hex);
      } else if (!strcmp("string.upper", n->strval)) {
	const char *str_origin = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	char *s = (char *)str_origin;
	char c;
	int i = 0;
	char *out;

	out = malloc(strlen(str_origin)+1);
	while (c = *s++) {
	  if ((c >= 'a') && (c <= 'z')) {
	    out[i] = c-32;
	  } else {
	    out[i] = c;
	  }
	  i++;
	}
	out[i] = '\0';

	kv_push(char *, ami->values_stack, out);
      } else if (!strcmp("string.lower", n->strval)) {
	const char *str_origin = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	char *s = (char *)str_origin;
	char c;
	int i = 0;
	char *out;

	out = malloc(strlen(str_origin)+1);
	while (c = *s++) {
	  if ((c >= 'A') && (c <= 'Z')) {
	    out[i] = c+32;
	  } else {
	    out[i] = c;
	  }
	  i++;
	}
	out[i] = '\0';

	kv_push(char *, ami->values_stack, out);
      } else if (!strcmp("hostname_generator", n->strval)) {
	const char *ipaddr = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	char vowels[] = {'a','e','i','o','u','y','a','e','i','o'};
	char consonants[] = {'p','b','c','z','m','f','d','s','t','r'};
	in_addr_t ipint;
	char *ia;
	size_t ia_len;
	size_t i;
	char retstr[11]; // size of max int len + 1

	if (!ipaddr) {
	  fprintf(stderr, "No such IP Address from %s\n", kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	  exit(1);
	}
	
	ipint = inet_addr(ipaddr);
	asprintf(&ia, "%d", ipint);
	ia_len = strlen(ia);

	for (i = 0; i < ia_len; i++) {
	  char pos = ia[i] - '0';
	  if (i%2) {
	    retstr[i] = vowels[pos];
	  } else {
	    retstr[i] = consonants[pos];
	  }
	}
	retstr[i] = '\0';
	free(ia);
	kv_push(char *, ami->values_stack, retstr); 	
	
      } else if (!strcmp("file.readall", n->strval)) {
	const char *filename = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	struct stat st;
	FILE *fp;
	off_t filesize;

	fp = fopen(filename, "rb");
	if (!fp) {
	  fprintf(stderr, "file.readall: Could not read file %s\n", filename);
	  return;
	}
	
	if (stat(filename, &st) == 0) {
	  filesize = st.st_size;
	} else {
	  fprintf(stderr, "file.readall: Error reading file %s\n", filename);
	  return;
	}
	unsigned char *file_content = malloc(filesize + 1);       
	fread(file_content, 1, filesize, fp);
	file_content[filesize] = '\0';
	fclose(fp);
	kv_push(char *, ami->values_stack, file_content);	       
      } else if (!strcmp("uuid.v4", n->strval)) { // random
	uuid_t uuid;
	char retstr[37];
	uuid_generate_random(uuid);
	uuid_unparse_lower(uuid, retstr);
	kv_push(char *, ami->values_stack, strdup((char *)retstr));
      } else if (!strcmp("uuid.v5", n->strval)) { // form string
	uuid_t uuid;
	uuid_t *uuid_template;
	const char *data = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	size_t data_len = strlen(data);
	char retstr[37];
	uuid_template = uuid_get_template("dns");
	uuid_generate_sha1(uuid, *uuid_template, (const char *)data, data_len);
	uuid_unparse_lower(uuid, retstr);
	kv_push(char *, ami->values_stack, strdup((char *)retstr));
      } else if (!strcmp("crypto.rc4", n->strval)) {
	ami_rc4_t rc4;
	char *value = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	size_t value_len = strlen(value);
	char *key = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-2));

	unsigned char *res = ami_rc4_do(&rc4, (unsigned char*)key, strlen(key), (unsigned char *)value, value_len);
	/* for (int count = 0; count < value_len; count++) { */
	/*   printf("res[]:%c\n", res[count]); */
	/* } */
	char *rc4hex = ami_rc4_to_hex(res, value_len);
	
	kv_push(char *, ami->values_stack, rc4hex);
	free(res);		    
      } else if (!strcmp("random.int", n->strval)) {
	time_t t;
	char *randstr;
	
	int to = (int)strtod(kv_A(ami->values_stack, kv_size(ami->values_stack)-1), NULL);
	int from = (int)strtod(kv_A(ami->values_stack, kv_size(ami->values_stack)-2), NULL);
	srand((unsigned) time(&t));
	int rout = (rand() % (to - from + 1)) + from;
	asprintf(&randstr, "%d", rout);
	kv_push(char *, ami->values_stack, randstr);		
      } else if (!strcmp("csv", n->strval)) {
	/* size_t stacklen = kv_size(ami->values_stack); */
	/* for (size_t i = 0; i < stacklen; i++) { */
	/*   printf("i:%d;val:%s\n", i, kv_A(ami->values_stack, i)); */
	/* }	 */
	
	int has_header = (int)strtod(kv_A(ami->values_stack, kv_size(ami->values_stack)-1), NULL);
	char *field = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-2));
	char *line_val = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-3));
	if (!line_val) {
	  fprintf(stderr, "Cannot get the variable value from %s\n", kv_A(ami->values_stack, kv_size(ami->values_stack)-3));
	  exit(1);
	}
	int line_in_csv = (int)strtod(line_val, NULL);
	char *file = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-4));

	/* printf("file:%s;line_in_csv:%d;field:%s;has_header:%d\n", file, line_in_csv, field, has_header); */
	char *result = ami_csvread_get_field_at_line(file, line_in_csv, field, has_header);
	if (!result) {
	  fprintf(stderr, "Error reading CSV file %s, field:%s, line:%d\n", file, field, line_in_csv);
	  exit(1);
	} else {
	  kv_push(char *, ami->values_stack, strdup(result));
	}
      } else if (!strcmp("replace", n->strval)) {
	kv_push(char *, ami->values_stack, "replace");// So we know we have a replace to perform
	/* printf("We are going to REPLACE!\n"); */
      } else {
      	fprintf(stderr, "Unhandled function:[%s]\n", n->strval);
	kv_push(char *, ami->values_stack, n->strval);
      }
      varpos = 0;
      break;
    case AMI_NT_SLEEP:
      ami->sleep_cursor += n->intval;
      ami->sleep_cursor += n->fval;
      break;
    }
  }
}

int ami_ast_walk_actions(ami_t *ami)
{
  
  if (!ami) {
    fprintf(stderr, "Ami is empty, cannot run %s!\n", __FUNCTION__);
    return -1;
  }

  if (!ami->root_node) {
    fprintf(stderr, "Ami root node is empty, cannot run %s!\n", __FUNCTION__);
    return -1;
  }

  walk_node(ami, ami->root_node, 0, 0);

  return 0;
}

