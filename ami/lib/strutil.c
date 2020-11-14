#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <ami/strutil.h>

char *ami_strutil_replace_all_substrings(const char *haystack, const char *needle, const char *replacement)
{
  size_t haystack_len;
  size_t needle_len;
  size_t replacement_len;
  size_t retstr_size = 0;
  size_t read_from_offset = 0;
  size_t read_to_offset = 0;
  
  int replace_count = 0;

  size_t write_offset = 0;
  const char *prevret = NULL;
  char *retstr = NULL;
  char *ret = NULL;
  size_t retlen = 0;

  if (!haystack) return NULL;
  if (!needle) return NULL;
  if (!replacement) return NULL;

  ret = strstr(haystack, needle);
  haystack_len = strlen(haystack);
  needle_len = strlen(needle);
  replacement_len = strlen(replacement);
  
  while (ret) {
    replace_count++;
    ret = strstr(ret+1, needle);
  }

  if (!replace_count) return NULL;

  retstr_size = haystack_len + (replace_count * (replacement_len - needle_len));  

  retstr = (char *)malloc(retstr_size + 1);
  memset(retstr, 0, retstr_size + 1);


  while ((ret = strstr(haystack + read_to_offset, needle))) {
    if (!haystack) return NULL;
    retlen = strlen(ret);
    read_to_offset = (haystack_len - retlen);
    
    memcpy(retstr + write_offset, haystack + read_from_offset, read_to_offset - read_from_offset);
    write_offset += read_to_offset - read_from_offset;
    memcpy(retstr + write_offset, replacement, replacement_len);
    write_offset += replacement_len;
    
    read_from_offset += read_to_offset + needle_len;
    read_to_offset += needle_len;
  }
  
  return retstr;
}

/* int main(int argc, char **argv) */
/* { */
/*   char *out; */

/*   out = replace_all_substrings("This$varFoo$var", "$var", "a"); */
/*   printf("out:%s\n", out); */
/*   free(out); */
  
/*   return 0; */
/* } */
