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
