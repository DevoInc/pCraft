#include <stdio.h>
#include <time.h>

#include <ami/ami.h>
#include <ami/ast.h>

void foreach_action(ami_action_t *action, void *u1, void *u2, void *u3)
{
  ami_t *ami = (ami_t *)u1;
  float sleep_cursor = action->sleep_cursor + action->sleep;
  char *name = ami_action_get_name(action);
  char *exec = ami_action_get_exec(action);  
  struct tm *t;

  if (ami->start_time > 0) {      
    t = gmtime((const time_t *)&ami->start_time);
    printf("%d-%s", 1900 + t->tm_year, t->tm_mon+1 < 10 ? "0" : "");
    printf("%d-%s%d ", t->tm_mon+1, t->tm_mday < 10 ? "0" : "",  t->tm_mday);
    printf("%d:%d:%d\n", t->tm_hour, t->tm_min, t->tm_sec);
  }
  /* printf("start time:%ld\n", gmtime(&ami->start_time)); */
  
  printf("action name:%s; exec:%s\n", name, exec);
  printf("sleep_cursor=%f\n", sleep_cursor);
}

int main(int argc, char **argv)
{
  ami_t *ami;
  int ret;
  
  if (argc < 3) {
    fprintf(stderr, "Syntax: %s file.ami file.dump\n", argv[0]);
    return -1;
  }
  
  ami = ami_new();

  ret = ami_parse_file(ami, argv[1]);

  ami_set_action_callback(ami, foreach_action, ami, NULL, NULL);

  ami_ast_walk_actions(ami);
  
  ami_close(ami);
  
  return 0;
}
