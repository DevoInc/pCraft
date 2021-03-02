#include <stdio.h>
#include <time.h>

#include "utils.h"

void ccraft_print_time(time_t time)
{
  struct tm *t;
  
  t = gmtime((const time_t *)&time);
  printf("%d-%s", 1900 + t->tm_year, t->tm_mon+1 < 10 ? "0" : "");
  printf("%d-%s%d ", t->tm_mon+1, t->tm_mday < 10 ? "0" : "",  t->tm_mday);
  printf("%d:%d:%d\n", t->tm_hour, t->tm_min, t->tm_sec);

}
