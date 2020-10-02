#include <stdio.h>
#include <stdlib.h>

#include <ami/flow.h>
#include <ami/kvec.h>
#include <ami/khash.h>

ami_flow_t *ami_flow_new()
{
  ami_flow_t *flow;

  flow = (ami_flow_t *)malloc(sizeof(ami_flow_t));
  if (!flow) {
    fprintf(stderr, "Cannot allocate ami_flow_t!\n");
    return NULL;
  }

  flow->type = AMI_FT_NONE;
  flow->func_name = NULL;
  kv_init(flow->func_arguments);
  flow->var_name = NULL;
  flow->var_value = NULL;
  flow->variables = kh_init(flowhash);
  flow->fields_to_replace = kh_init(flowhash);
  flow->exec = NULL;
  flow->replace_field = NULL;
  
  return flow;
}

char *ami_flow_type_as_string(ami_flow_t *flow)
{
  switch(flow->type) {
  case AMI_FT_NONE:
    return "AMI_FT_NONE";
  case AMI_FT_SETVAR:
    return "AMI_FT_SETVAR";
  case AMI_FT_ACTION:
    return "AMI_FT_ACTION";
  case AMI_FT_RUNFUNC:
    return "AMI_FT_RUNFUNC";
  case AMI_FT_REPLACE:
    return "AMI_FT_REPLACE";
  default:
    return "Invalid flow type!\n";    
  }
}

void ami_flow_debug(ami_flow_t *flow)
{
  printf("AMI flow\n=========\n");
  printf("\ttype:%s\n", ami_flow_type_as_string(flow));
  switch(flow->type) {
  case AMI_FT_NONE:
    return;
    break;
  case AMI_FT_SETVAR:
    printf("\tvar_name:%s\n", flow->var_name);
    printf("\tvar_value:%s\n", flow->var_value);
    break;
  case AMI_FT_ACTION:
    printf("\texec:%s\n", flow->exec);
    break;
  case AMI_FT_RUNFUNC:
    printf("\tfunc_name:%s\n", flow->func_name);
    size_t args_array = kv_size(flow->func_arguments);
    if (args_array > 0) {
      for (size_t i = 0; i < args_array; i++) {
	char *arg = kv_A(flow->func_arguments, i);
	printf("arg %d: %s\n", i, arg);       
      }      
    }
    break;
  case AMI_FT_REPLACE:
    printf("\treplace_field:%s\n", flow->replace_field);
    break;
  }
}

void ami_flow_close(ami_flow_t *flow)
{
  khint_t k;

  free(flow->func_name);
  
  for (k = 0; k < kh_end(flow->variables); ++k) {
    if (kh_exist(flow->variables, k)) {
      free((char *)kh_key(flow->variables, k));
      free((char *)kh_value(flow->variables, k));
      kh_del(flowhash, flow->variables, k);
    }
  }
}
