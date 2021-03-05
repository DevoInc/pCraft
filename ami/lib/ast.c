#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <time.h>
#include <string.h>
#include <errno.h>
#include <math.h>

#include <sys/stat.h>
#include <sys/types.h>

#include <sys/socket.h> 
#include <netinet/in.h>
#include <arpa/inet.h>
#include <netdb.h>

#include <libgen.h>


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
  char maxint[50]; // There is no way an int would be longer than 49 chars
  
  replaced_buf = strdup(strval);

  if (ami->variables) {
    for (k = 0; k < kh_end(ami->variables); ++k) {
      if (kh_exist(ami->variables, k)) {
	char *key = (char *)kh_key(ami->variables, k);
	ami_variable_t *value = (ami_variable_t *)kh_value(ami->variables, k);
	/* if (value->type != AMI_VAR_STR) { */
	/*   fprintf(stderr, "Error: Can only get value from a string variable!\n"); */
	/*   return replaced_buf; */
	/* } */
	char *replacevar = ami_strutil_make_replacevar(key);
	if (replaced_buf) {
	  found = strstr(replaced_buf, replacevar);
	  if (found) {
	    char *new_replaced_buf = ami_strutil_replace_all_substrings(replaced_buf, replacevar, ami_variable_to_string(value));
	    /* printf("Calling ami_strutil_replace_all_substrings. replacedbuf:%s;replacevar:%s;value->srtval:%s\n", replaced_buf, replacevar, value->strval); */
	    free(replaced_buf);
	    replaced_buf = new_replaced_buf;
	  }
	}
	free(replacevar);
      }
    }
  }
  /* else { */
  /*   printf("There is no variables for AMI!\n"); */
  /* } */

  return replaced_buf;
}

static void walk_node(ami_t *ami, ami_node_t *node, int repeat_index, int right)
{
  ami_node_t *n;
  ami_action_t *action;
  int index = 0;
  char *stack_str = NULL; // Keeping the last value
  int stack_int = 0;
  char *tmp_str;
  float tmp_float;
  /* static char *csv_args[4] = { NULL, NULL, NULL, NULL }; // For now, we only have the CSV function */
  kvec_t(char *) values_stack;
  static int varpos = 0;  
  ami_field_action_t *field_action;
  char *replaced_var = NULL;
  int repeat_n = 0;
  size_t array_values_len = 0;
  int array_get_index = 0;
  
  ami_variable_t *globalvar;
  ami_variable_t *localvar;
  ami_variable_t *tmp_var = NULL;

  /* Random seed */
  FILE *urandom;
  unsigned int seed;
  size_t seedret;
  
  urandom = fopen("/dev/urandom", "r");
 
  
  for (n = node; n; n = n->next) {

    ami_global_counter_incr(ami); // used for better random numbers
    
    if ((n->strval) && (!n->is_verbatim)) {
      if ((n->type == AMI_NT_VARVALSTR) || (n->type == AMI_NT_MESSAGE)) {
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

      if (repeat_index >= 0) {
	/* ami_field_action_debug(action); */
	if (right) {
	  action->repeat_index = repeat_index;
	}
	action->sleep_cursor = ami->sleep_cursor;
	/* action = ami_action_copy_variables(ami, action); */
	if (ami->action_cb) {
	  ami->action_cb(action, ami->action_cb_userdata1, ami->action_cb_userdata2, ami->action_cb_userdata3);
	} else {
	  fprintf(stderr,"*** Warning: No Action Callback Set!\n");
	}
      }
      ami_action_close(action);
      /* ami_erase_local_variables(ami); */
      break;
    case AMI_NT_REPEAT:      
      /* ami->current_repeat_block++; */
      tmp_str = kv_A(ami->values_stack, kv_size(ami->values_stack)-1);
      index = (int)strtod(tmp_str, NULL);
      
      tmp_var = ami_variable_new();
      for (size_t i = 1; i <= index; i++) {
	ami_variable_set_int(tmp_var, i);
	ami_set_variable(ami, n->strval, tmp_var);
	
	walk_node(ami, n->next, i, 1);
      }
      break;
    case AMI_NT_REPEATCLOSE:
      ami->current_repeat_block--;
      break;
    case AMI_NT_MESSAGE:
      if (replaced_var) {
	printf("%s\n", replaced_var);
      } else {
	printf("%s\n", n->strval);
      }
      break;
    case AMI_NT_VARVALSTR:
      if (replaced_var) {
	kv_push(char *, ami->values_stack, strdup(replaced_var));
	free(replaced_var);
      } else {
	kv_push(char *, ami->values_stack, strdup(n->strval));
      }
      break;
    case AMI_NT_VARVALINT:
      asprintf(&tmp_str, "%d", n->intval);
      kv_push(char *, ami->values_stack, strdup(tmp_str));
      free(tmp_str);
      /* kv_a(char *, ami->values_stack, strdup(n->strval)); */
      break;
    case AMI_NT_VARVALFLOAT:
      asprintf(&tmp_str, "%f", n->fval);
      kv_push(char *, ami->values_stack, strdup(tmp_str));
      free(tmp_str);
      /* kv_a(char *, ami->values_stack, strdup(n->strval)); */
      break;
    case AMI_NT_VARVAR:
		kv_push(char *, ami->varvar_stack, strdup(n->strval));
		kv_push(char *, ami->values_stack, strdup(n->strval));
      	break;
    case AMI_NT_VARNAME:
		if (array_get_index > 0) {
			char *lastval = kv_A(ami->values_stack, kv_size(ami->values_stack)-1);
			ami_variable_t *arrayfrom = ami_get_variable(ami, lastval);
			if (arrayfrom) {
	  			ami_variable_t *var = ami_variable_array_get_at_index(arrayfrom, array_get_index);
	  			ami_set_variable(ami, n->strval, ami_variable_copy(var));
			} else {
	  			fprintf(stderr, "Could not fetch our array to the global variable!\n");
			}
			free(lastval);
      	} else {
			globalvar = ami_get_variable(ami, n->strval);
			tmp_str = kv_A(ami->values_stack, kv_size(ami->values_stack)-1);
			if (!tmp_str) {
			fprintf(stderr, "Error: no such value for '%s'\n", kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
			exit(1);
			}
	
			char *varvar = NULL;
			int is_varvar = 0;

			for (int i=1; i <= kv_size(ami->varvar_stack); i++) {
				varvar = kv_A(ami->varvar_stack, kv_size(ami->varvar_stack)-i);
				if (strcmp(varvar, tmp_str) == 0) {
					is_varvar = 1;
					break;
				}
			}

			if (!globalvar) {
				if (is_varvar) {
					globalvar = ami_variable_new_variable(tmp_str);
				} else {
					globalvar = ami_variable_new_string(tmp_str);
				}
			} else {
				if (is_varvar) {
					ami_variable_set_variable(globalvar, tmp_str);
				} else {
					ami_variable_set_string(globalvar, tmp_str);
				}
			}
			ami_set_variable(ami, n->strval, globalvar);
			free(tmp_str);
      	}

      	array_get_index = 0;
      	break;
    case AMI_NT_LOCALVARNAME:
      if (array_get_index > 0) {
	char *lastval = kv_A(ami->values_stack, kv_size(ami->values_stack)-1);
	ami_variable_t *arrayfrom = ami_action_get_variable(action, lastval);
	if (arrayfrom) {
	  ami_variable_t *var = ami_variable_array_get_at_index(arrayfrom, array_get_index);
	  ami_action_set_variable(action, n->strval, ami_variable_copy(var));
	} else {
	  fprintf(stderr, "Could not fetch our array to the local variable!\n");
	}
	free(lastval);
      } else {
	localvar = ami_action_get_variable(action, n->strval);
	tmp_str = kv_A(ami->values_stack, kv_size(ami->values_stack)-1);
	if (!tmp_str) {
	  fprintf(stderr, "Error: no such value for '%s'\n", kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	  exit(1);
	}
	if (!localvar) {
	  localvar = ami_variable_new_string(tmp_str);
	}
	ami_action_set_variable(action, n->strval, localvar);
	free(tmp_str);
      }
      array_get_index = 0;
      break;
    case AMI_NT_FIELDFUNC:
      /* printf("Fieldfunc :%s\n", n->strval); // ip */
      if (!strcmp("replace", kv_A(ami->values_stack, kv_size(ami->values_stack)-1))) {
	size_t stacklen = kv_size(ami->values_stack);
	
	for (int i = 1; i <= ami->replace_count; i++) {
	  int pos_to = (i*-1)-i; 
	  int pos_from = (i*-1)-(i+1);
	  char *to = kv_A(ami->values_stack, stacklen+pos_to);
	  char *from = kv_A(ami->values_stack, stacklen+pos_from);

	  field_action = ami_field_action_new();
	  field_action->field = n->strval;
	  field_action->action = "replace";
	  field_action->left = ami_get_nested_variable_as_str(ami, n,from);
	  field_action->right = ami_get_nested_variable_as_str(ami, n,to);
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
      char *vstr = kv_A(ami->values_stack, kv_size(ami->values_stack)-1);
      char *value = ami_get_nested_variable_as_str(ami, n,vstr);
      if (!value) {
	fprintf(stderr, "[line:%d] Error getting value for field %s\n", n->lineno, n->strval);
	exit(1);
      }
      field_action->right = value;

      if (!action) {
	fprintf(stderr, "No Action created!\n");
      } else {
	action->field_actions = ami_field_action_append(action->field_actions, field_action);
      }
      break;
    /* case AMI_NT_REPLACE: */
    /*   { */
    /* 	/\* ami_print_all_variables(ami); *\/ */
    /* 	/\* char *replace_with = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-1)); *\/ */
    /* 	/\* printf("replace:%s with:%s\n", n->strval, replace_with); *\/ */
    /* 	kv_push(char *, ami->values_stack, strdup(n->strval)); */
    /* 	ami->replace_count++; */
    /*   } */
    /*   break; */
    case AMI_NT_REPLACE:
      {
	
	/* char *replace_to_str = kv_A(ami->values_stack, kv_size(ami->values_stack)-1); */
	/* char *replace_from_str = kv_A(ami->values_stack, kv_size(ami->values_stack)-2); */

	/* printf("AST -> replace %s => %s\n", replace_from_str, replace_to_str); */
	
	/* ami_variable_t *replace_from = ami_get_variable(ami, replace_from_str); */
	/* if (replace_from) { */
	/*   char *varstr = ami_variable_to_string(replace_from); */
	/*   printf("FROM VAR\n"); */
	/*   kv_push(char *, ami->values_stack, strdup(varstr)); */
	/* } else { */
	/*   kv_push(char *, ami->values_stack, strdup(replace_from_str)); */
	/* } */
	/* ami_variable_free(replace_from); */
	
	ami->replace_count++;
      }
      break;
    case AMI_NT_FUNCTION:
      if (!strcmp("base64.encode", n->strval)) {
	char *data = kv_A(ami->values_stack, kv_size(ami->values_stack)-1);
	char *b64 = base64_enc_malloc(data, strlen(data));
	kv_push(char *, ami->values_stack, b64);	
      } else if (!strcmp("base64url.encode", n->strval)) {
	char *data = kv_A(ami->values_stack, kv_size(ami->values_stack)-1);
	char *b64 = base64url_enc_malloc(data, strlen(data));
	kv_push(char *, ami->values_stack, b64);	
      } else if (!strcmp("add", n->strval)) {
	char *left_s = kv_A(ami->values_stack, kv_size(ami->values_stack)-2);
	char *right_s = kv_A(ami->values_stack, kv_size(ami->values_stack)-1);	
	ami_variable_t *left = ami_get_variable(ami, left_s);
	int left_int;
	int right_int;
	int total;
	char *outstr;

	if (!left) {
	  left_int = (int)strtod(left_s, NULL);
	} else {
	  left_int = ami_variable_to_int(left);
	}
	ami_variable_t *right = ami_get_variable(ami, right_s);
	if (!right) {
	  right_int = (int)strtod(right_s, NULL);
	} else {
	  right_int = ami_variable_to_int(right);
	}

	total = left_int + right_int;
	asprintf(&outstr, "%d", total);
	
	kv_push(char *, ami->values_stack, outstr);	
      } else if (!strcmp("random.macaddr", n->strval)) {
	char macchars[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};
	char *randstr = malloc(18);
	int rout;

	seedret = fread(&seed, sizeof(unsigned int), 1, urandom);
	if (!seedret) {
	  fprintf(stderr, "Error reading /dev/urandom!\n");
	}
	srand((unsigned int)seed);
	
	if (!randstr) {
	  fprintf(stderr, "Error[random.macaddr]: Could not allocate random string!\n");
	  exit(1);
	}
	memset(randstr, 0, 18);
	for (int i=0; i < 17; i++) {
	  switch(i) {
	  case 2:
	  case 5:
	  case 8:
	  case 11:
	  case 14:
	    randstr[i] = ':';
	    break;
	  default:
	    rout = rand() % 16;
	    randstr[i] = macchars[rout];
	  }
	}

	kv_push(char *, ami->values_stack, strdup(randstr));
	free(randstr);
      } else if (!strcmp("sin", n->strval)) {
	ami_variable_t *arg = ami_get_variable(ami, kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	char *arg_str = ami_variable_to_string(arg);
	float fval = (float)strtof(arg_str, NULL);
	float fres = sinf(fval);
	char *outstr;
	asprintf(&outstr, "%f", fres);
	kv_push(char *, ami->values_stack, outstr);	
      } else if (!strcmp("ip.gethostbyname", n->strval)) {
	struct hostent *he;
	const char *hostname = ami_get_nested_variable_as_str(ami, n,kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	char ipstr[INET6_ADDRSTRLEN];
	
	he = gethostbyname(hostname);
	if (!he) {
	  fprintf(stderr, "Could not resolve '%s'\n", hostname);
	  exit(1);
	}

	if (inet_ntop(AF_INET, (const void *)he->h_addr_list[0], ipstr, sizeof(ipstr)) == NULL) {
	  fprintf(stderr, "Cannot convert IP address %s: %s\n", kv_A(ami->values_stack, kv_size(ami->values_stack)-1), strerror(errno));
	  exit(1);
	}

	kv_push(char *, ami->values_stack, ipstr);	
      } else if (!strcmp("ip.cidr",n->strval)) {
	static const uint32_t cidr_table[] = { 0x00000000, 0x00000080, 0x000000c0, 0x000000e0, 0x000000f0,
					       0x000000f8, 0x000000fc, 0x000000fe, 0x000000ff, 0x000080ff,
					       0x0000c0ff, 0x0000e0ff, 0x0000f0ff, 0x0000f8ff, 0x0000fcff,
					       0x0000feff, 0x0000ffff, 0x0080ffff, 0x00c0ffff, 0x00e0ffff,
					       0x000fffff, 0x00f8ffff, 0x00fcffff, 0x00feffff, 0x00ffffff,
					       0x80ffffff, 0xc0ffffff, 0xe0ffffff, 0xf0ffffff, 0xf8ffffff,
					       0xfcffffff, 0xfeffffff, 0xffffffff};
	char *ipaddr_s = kv_A(ami->values_stack, kv_size(ami->values_stack)-2);
	char *ipnum_s = kv_A(ami->values_stack, kv_size(ami->values_stack)-1);	
	ami_variable_t *ipaddr_v = ami_get_variable(ami, ipaddr_s);
	ami_variable_t *ipnum_v = ami_get_variable(ami, ipnum_s);
	char *ipaddr = ami_variable_to_string(ipaddr_v);
	int ipn = 1;
	if (ipnum_v) {
	  ipn = ami_variable_to_int(ipnum_v);
	} else {
	  ipn = ami_get_nested_variable_as_int(ami, ipnum_s);;
	}
	int ret;
	struct in_addr addr4;
	struct in_addr out_network;
	struct in_addr out_broadcast;
	struct in_addr addr_iter;
	char ret_network[INET6_ADDRSTRLEN];
	const char ret_broadcast[INET6_ADDRSTRLEN];
	char *ip, *mask;
	int mask_int;
	int counter;

	if (!ipaddr) {
	  fprintf(stderr, "No such IP Address from %s\n", kv_A(ami->values_stack, kv_size(ami->values_stack)-2));
	  exit(1);	  
	}

	ip = strtok(ipaddr, "/");
	if (!ip) {
	  fprintf(stderr, "Could not get ip from %s\n", kv_A(ami->values_stack, kv_size(ami->values_stack)-2));
	  exit(1);
	}

	mask = strtok(NULL, "\0");
	if (!mask) {
	  fprintf(stderr, "Could not get mask from %s\n", kv_A(ami->values_stack, kv_size(ami->values_stack)-2));
	  exit(1);
	}
	mask_int = (int)strtod(mask, NULL);
	if ((mask_int > 32) || (mask_int < 0)) {
	  fprintf(stderr, "Invalid mask: %d\n", mask_int);
	  exit(1);
	}
	
	ret = inet_pton(AF_INET, ip, &addr4);
	switch(ret) {
	case 1: // Success
	  break;
	case 0:
	  fprintf(stderr, "Invalid network address: %s\n", kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	  exit(1);
	  break;
	case -1:
	  fprintf(stderr, "IP Conversion Error: %s\n", strerror(errno));
	  exit(1);
	  break;
	}
	
	out_network.s_addr = ntohl(addr4.s_addr & cidr_table[mask_int]);
	out_broadcast.s_addr = ntohl(addr4.s_addr | ~cidr_table[mask_int]);

	counter = 0;
	for (addr_iter.s_addr = out_network.s_addr; addr_iter.s_addr <= out_broadcast.s_addr; addr_iter.s_addr++) {
	  struct in_addr out;
	  out.s_addr = ntohl(addr_iter.s_addr);
	  if (inet_ntop(AF_INET, (const void *)&out, ret_network, sizeof(ret_network)) == NULL) {
	    fprintf(stderr, "Cannot convert IP address %s: %s\n", kv_A(ami->values_stack, kv_size(ami->values_stack)-2), strerror(errno));
	    exit(1);
	  }

	  if (counter == ipn) {
	    break;
	  }
	  
	  counter++;
	}

	/* if (inet_ntop(AF_INET, (const void *)&out_network, ret_network, sizeof(ret_network)) == NULL) { */
	/*   fprintf(stderr, "Cannot convert IP address %s: %s\n", kv_A(ami->values_stack, kv_size(ami->values_stack)-2), strerror(errno)); */
	/*   exit(1); */
	/* } */
	/* if (inet_ntop(AF_INET, (const void *)&out_broadcast, ret_broadcast, sizeof(ret_broadcast)) == NULL) { */
	/*   fprintf(stderr, "Cannot convert IP address %s: %s\n", kv_A(ami->values_stack, kv_size(ami->values_stack)-2), strerror(errno)); */
	/*   exit(1); */
	/* } */

	/* printf("Network return:%s, broadcast:%s\n", ret_network, ret_broadcast); */
	
	kv_push(char *, ami->values_stack, strdup(ret_network));
      } else if (!strcmp("crypto.md5", n->strval)) {
	const char *strbuf = ami_get_nested_variable_as_str(ami, n,kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	MD5_CTX ctx;
	unsigned char buf[16];
	
	md5_init(&ctx);
	md5_update(&ctx, strbuf, strlen(strbuf));
	md5_final(&ctx, buf);

	char *hex = ami_rc4_to_hex(buf, 16);	
	kv_push(char *, ami->values_stack, hex);
      } else if (!strcmp("crypto.sha1", n->strval)) {
	const char *strbuf = ami_get_nested_variable_as_str(ami, n,kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	SHA1_CTX ctx;
	unsigned char buf[SHA1_BLOCK_SIZE];
	
	sha1_init(&ctx);
	sha1_update(&ctx, strbuf, strlen(strbuf));
	sha1_final(&ctx, buf);

	char *hex = ami_rc4_to_hex(buf, SHA1_BLOCK_SIZE);	
	kv_push(char *, ami->values_stack, hex);
      } else if (!strcmp("crypto.sha256", n->strval)) {
	const char *strbuf = ami_get_nested_variable_as_str(ami, n,kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	SHA256_CTX ctx;
	unsigned char buf[SHA256_BLOCK_SIZE];
	
	sha256_init(&ctx);
	sha256_update(&ctx, strbuf, strlen(strbuf));
	sha256_final(&ctx, buf);

	char *hex = ami_rc4_to_hex(buf, SHA256_BLOCK_SIZE);	
	kv_push(char *, ami->values_stack, hex);
      } else if (!strcmp("string.upper", n->strval)) {
	const char *str_origin = ami_get_nested_variable_as_str(ami, n,kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
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
	const char *str_origin = ami_get_nested_variable_as_str(ami, n,kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
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
	const char *ipaddr = ami_get_nested_variable_as_str(ami, n,kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
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
	
      } else if (!strcmp("file.amidir", n->strval)) {
	const char *filename = ami_get_nested_variable_as_str(ami, n,kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	char *result;
	char *dname, *da;
	da = strdup(ami->file);
	dname = dirname(da);
	asprintf(&result,"%s/%s", dname, filename);
	free(da);
	kv_push(char *, ami->values_stack, result);
      } else if (!strcmp("file.readall", n->strval)) {
	const char *filename = ami_get_nested_variable_as_str(ami, n,kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
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
	char *b64 = base64url_enc_malloc(file_content, filesize);

	kv_push(char *, ami->values_stack, b64);	       
      } else if (!strcmp("file.linescount", n->strval)) {
	const char *filename = ami_get_nested_variable_as_str(ami, n,kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	struct stat st;
	FILE *fp;
	size_t readf;
	char readbuf;
	size_t nlines = 0;
	char *outstr;
	
	fp = fopen(filename, "rb");
	if (!fp) {
	  fprintf(stderr, "file.readall: Could not read file %s\n", filename);
	  return;
	}

	fseek(fp, 0, SEEK_SET);
	
	while ((readf = fread(&readbuf, 1, 1, fp)) > 0) {
	  if (readbuf == '\n') {
	    nlines++;
	  }
	}

	asprintf(&outstr, "%ld", nlines);
	kv_push(char *, ami->values_stack, outstr);
      } else if (!strcmp("uuid.v4", n->strval)) { // random
	uuid_t uuid;
	char retstr[37];
	uuid_generate_random(uuid);
	uuid_unparse_lower(uuid, retstr);
	kv_push(char *, ami->values_stack, strdup((char *)retstr));
      } else if (!strcmp("uuid.v5", n->strval)) { // form string
	uuid_t uuid;
	const uuid_t *uuid_template;
	const char *data = ami_get_nested_variable_as_str(ami, n,kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	size_t data_len = strlen(data);
	char retstr[37];
	uuid_template = uuid_get_template("dns");
	uuid_generate_sha1(uuid, *uuid_template, (const char *)data, data_len);
	uuid_unparse_lower(uuid, retstr);
	kv_push(char *, ami->values_stack, strdup((char *)retstr));
      } else if (!strcmp("crypto.rc4", n->strval)) {
	ami_rc4_t rc4;
	char *value = ami_get_nested_variable_as_str(ami, n,kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	size_t value_len = strlen(value);
	char *key = ami_get_nested_variable_as_str(ami, n,kv_A(ami->values_stack, kv_size(ami->values_stack)-2));

	unsigned char *res = ami_rc4_do(&rc4, (unsigned char*)key, strlen(key), (unsigned char *)value, value_len);
	/* for (int count = 0; count < value_len; count++) { */
	/*   printf("res[]:%c\n", res[count]); */
	/* } */
	char *rc4hex = ami_rc4_to_hex(res, value_len);
	
	kv_push(char *, ami->values_stack, rc4hex);
	free(res);		    
      } else if (!strcmp("random.int", n->strval)) {
	char *randstr;

	int to = (int)strtod(kv_A(ami->values_stack, kv_size(ami->values_stack)-1), NULL);
	int from = (int)strtod(kv_A(ami->values_stack, kv_size(ami->values_stack)-2), NULL);

	seedret = fread(&seed, sizeof(unsigned int), 1, urandom);
	if (!seedret) {
	  fprintf(stderr, "Error reading /dev/urandom!\n");
	}
	srand((unsigned int)seed);

	int rout = (rand() % (to - from + 1)) + from;
	asprintf(&randstr, "%d", rout);
	kv_push(char *, ami->values_stack, randstr);		
      } else if (!strcmp("random.float", n->strval)) {
	char *randstr;

	seedret = fread(&seed, sizeof(unsigned int), 1, urandom);
	if (!seedret) {
	  fprintf(stderr, "Error reading /dev/urandom!\n");
	}
	srand((unsigned int)seed);
	
	float to = (float)strtof(kv_A(ami->values_stack, kv_size(ami->values_stack)-1), NULL);
	float from = (float)strtof(kv_A(ami->values_stack, kv_size(ami->values_stack)-2), NULL);

	float anything = sin(rand() * rand());
	float rout = to + (from - to) * fabs(anything);

	asprintf(&randstr, "%f", rout);
	kv_push(char *, ami->values_stack, randstr);		
      } else if (!strcmp("random.string", n->strval)) {
	char *randstr;

	int stringlen = (int)strtod(kv_A(ami->values_stack, kv_size(ami->values_stack)-1), NULL);
	if (stringlen <= 0) {
	  fprintf(stderr, "Error[random.string]: should be at least 1.");
	  exit(1);
	}
	randstr = malloc(stringlen+1);
	if (!randstr) {
	  fprintf(stderr, "Error[random.string]: Could not allocate random string!\n");
	  exit(1);
	}
	memset(randstr, 0, stringlen+1);

	for (int i=0; i < stringlen; i++) {
	  int rout = (rand() % (122 - 97 + 1)) + 97;
	  randstr[i] = rout;
	}
	
	kv_push(char *, ami->values_stack, strdup(randstr));		
	free(randstr);
      } else if (!strcmp("random.hexstring", n->strval)) {
	char *randstr;
	char hexchars[16] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f'};

	seedret = fread(&seed, sizeof(unsigned int), 1, urandom);
	if (!seedret) {
	  fprintf(stderr, "Error reading /dev/urandom!\n");
	}
	srand((unsigned int)seed);

	int stringlen = (int)strtod(kv_A(ami->values_stack, kv_size(ami->values_stack)-1), NULL);
	if (stringlen <= 0) {
	  fprintf(stderr, "Error[random.string]: should be at least 1.");
	  exit(1);
	}
	randstr = malloc(stringlen+1);
	if (!randstr) {
	  fprintf(stderr, "Error[random.string]: Could not allocate random string!\n");
	  exit(1);
	}
	memset(randstr, 0, stringlen+1);

	for (int i=0; i < stringlen; i++) {
	  int rout = rand() % 16;
	  randstr[i] = hexchars[rout];
	}
	
	kv_push(char *, ami->values_stack, strdup(randstr));
	free(randstr);
    } else if (!strcmp("csv", n->strval)) {
		/*size_t stacklen = kv_size(ami->values_stack);
		for (size_t i = 0; i < stacklen; i++) {
			printf("[kvec] i:%d;val:%s\n", i, kv_A(ami->values_stack, i));
		}*/
	
		int has_header = (int)strtod(kv_A(ami->values_stack, kv_size(ami->values_stack)-1), NULL);
		char *field = kv_A(ami->values_stack, kv_size(ami->values_stack)-2);
		char *line_val_stack = kv_A(ami->values_stack, kv_size(ami->values_stack)-3);

		/* CSV line number can be provided as a variable or an integer */
		int csvline;
		if (ami_variable_exists(ami, line_val_stack)) {
			ami_variable_t *line_in_csv = ami_get_variable(ami, line_val_stack);
			if (!line_in_csv) {
				fprintf(stderr, "Could not get the variable from '%s', line:%d\n", line_val_stack, n->lineno);
			} else {
				csvline = ami_variable_to_int(line_in_csv);
			}
		} else {
			csvline = atoi(line_val_stack);
			fprintf(stderr, "csvline: %d\n", csvline);
		}

		if (csvline == 0) {
			fprintf(stderr, "Invalid line number: %s", line_val_stack);
		}
	
		char *file = kv_A(ami->values_stack, kv_size(ami->values_stack)-4);
		char *result = ami_csvread_get_field_at_line(ami, file, csvline, field, has_header);
		
		if (!result) {
			fprintf(stderr, "[line:%d] Error reading CSV file %s, field:%s, line:%d\n", n->lineno, file, field, csvline);
			exit(1);
		} else {
			kv_push(char *, ami->values_stack, strdup(result));
		}

    } else if (!strcmp("csv.linescount", n->strval)) {
	const char *filename = ami_get_nested_variable_as_str(ami, n,kv_A(ami->values_stack, kv_size(ami->values_stack)-1));
	struct stat st;
	FILE *fp;
	size_t readf;
	char readbuf;
	size_t nlines = 0;
	char *outstr;
	
	fp = fopen(filename, "rb");
	if (!fp) {
	  fprintf(stderr, "file.readall: Could not read file %s\n", filename);
	  return;
	}

	fseek(fp, 0, SEEK_SET);
	
	while ((readf = fread(&readbuf, 1, 1, fp)) > 0) {
	  if (readbuf == '\n') {
	    nlines++;
	  }
	}

	nlines--;
	
	asprintf(&outstr, "%ld", nlines);
	kv_push(char *, ami->values_stack, outstr);
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
      // <toremove>
      if (!n->strval) { // The old way does not have the group implemented
	if (repeat_index >= 0) { // Should be removed. Also, why do I have this condition?
	  tmp_str = kv_A(ami->values_stack, kv_size(ami->values_stack)-1);
	  tmp_float = (float)strtof(tmp_str, NULL);
	  ami->sleep_cursor += tmp_float;
	}
      }
      // </toremove>
      
      tmp_str = kv_A(ami->values_stack, kv_size(ami->values_stack)-1);
      tmp_float = (float)strtof(tmp_str, NULL);
      if (n->strval) { // We have strval? = we have a group
	char *groupval = _replace_strval_from_variables(ami, n->strval);
	if (!groupval) {
	  printf("This is n->strval:%s\n", n->strval);
	}
	ami_append_sleep_cursor(ami, groupval, tmp_float);
      } else { // No strval, so this is going to the "_global" group
	ami_append_sleep_cursor(ami, "_global", tmp_float);
      }      
      break;
    case AMI_NT_SLEEP_FROMGROUP:
      if (!action) {
	fprintf(stderr, "Error: Cannot use \"sleep fromgroup\" outside of an action!\n");
	exit(1);
      }
      if (n->strval) {
      	char *groupval = _replace_strval_from_variables(ami, n->strval);
	action->sleep += ami_get_new_sleep_cursor(ami, groupval);
      } else {
	fprintf(stderr, "Error, no group found!\n");
	exit(1);
      }

      break;
    case AMI_NT_ARRAYVAR:
      /* printf("We set the values for our array. We have %d values\n", n->intval); */
      array_values_len = n->intval;
      localvar = ami_variable_new();
      for (size_t i = array_values_len; i > 0; i--) {
	ami_variable_t *var = ami_variable_new();
      	ami_variable_set_string(var, kv_A(ami->values_stack, kv_size(ami->values_stack)-i));
	ami_variable_array_append(localvar, var);
      }
      ami_action_set_variable(action, n->strval, ami_variable_copy(localvar));
      /* tmp_var = ami_action_get_newvariable(action, n->strval); */
      /* ami_variable_debug(localvar); */
      
      break;
    case AMI_NT_ARRAYGET:
      /* array_get_index = n->intval; */
      tmp_str = kv_A(ami->values_stack, kv_size(ami->values_stack)-1);
      /* printf("str:%s\n", tmp_str); */
      if (tmp_str) {
	ami_variable_t *var = ami_action_get_variable(action, n->strval);
	if (!var) {
	  printf("Cannot get variable %s\n", n->strval);
	}
	ami_variable_debug(var);
      }
      printf("Get from array:%s; variable name:%s\n", tmp_str, n->strval);
      kv_push(char *, ami->values_stack, strdup(n->strval));
      
      break;
    case AMI_NT_EXIT:
      exit(1);
      break;      
    } // switch(n->type)

    if (n->right) {
      if (!ami->skip_repeat) {
	walk_node(ami, n->right, -1, 1);
      }
    }
  } // For loop

  fclose(urandom);
  
}

int ami_ast_walk_actions(ami_t *ami)
{
  time_t t;
  srand((unsigned) time(&t));
  
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

