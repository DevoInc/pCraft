#include <ami/action.h>

int main(int argc, char **argv)
{
  ami_action_t *action;
  action = ami_action_new();
  ami_action_close(action);
  return 0;
}
