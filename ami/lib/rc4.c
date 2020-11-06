#include <stdio.h>
#include <string.h>
#include <stdlib.h>

#include <ami/rc4.h>

void ami_rc4_init(ami_rc4_t *rc4, unsigned char *key, size_t key_len)
{
  int j = 0;
  int i;
  unsigned char tmpval;
  
  for (i = 0; i <= 255; i++) {
    rc4->s[i] = i;
  }

  for (i = 0; i <= 255; i++) {
    j = (j + rc4->s[i] + key[i % key_len]) % 256;
    
    tmpval=rc4->s[j];
    rc4->s[j] = rc4->s[i];
    rc4->s[i] = tmpval;
  }
  
}

unsigned char *ami_rc4_do(ami_rc4_t *rc4, unsigned char *key, size_t key_len, unsigned char *data, size_t data_len)
{
  int i = 0;
  int j = 0;
  unsigned char tmpval;
  unsigned char *outbuf;
  

  ami_rc4_init(rc4, key, key_len);
  
  outbuf = malloc(strlen((const char *)data) + 1);
  if (!outbuf) {
    fprintf(stderr, "Cannot allocate the output buffer!\n");
    return NULL;
  }

  memset(outbuf, 0, data_len);
  
  int cursor;
  while(cursor < data_len) {

    i = (i+1) % 256;
    j = (j+rc4->s[i]) % 256;
    tmpval = rc4->s[j];
    rc4->s[j] = rc4->s[i];
    rc4->s[i] = tmpval;
    tmpval = rc4->s[(rc4->s[i] + rc4->s[j])%256];
    outbuf[cursor] = data[cursor] ^ tmpval;
    cursor++;
  }

  return outbuf;
}

char *ami_rc4_to_hex(unsigned char *data, size_t data_len)
{
  char *buffer;
  size_t buffer_cursor = 0;
  static const char hex[] = "0123456789abcdef";
  size_t i;

  buffer = malloc((data_len * 2)+1);
  if (!buffer) {
    fprintf(stderr, "Cannot allocate buffer to contain rc4 hex!\n");
    return NULL;
  }
  
  for (i = 0; i < data_len; i++) {
    unsigned int val = *data++;
    buffer[buffer_cursor] = hex[val >> 4];
    buffer_cursor++;
    buffer[buffer_cursor] = hex[val & 0xf];
    buffer_cursor++;
  }
  buffer[buffer_cursor] = '\0';
  
  return buffer;
}


/* int main(int argc, char **argv) */
/* { */
/*   rc4_t rc4; */

/*   unsigned char *key = (unsigned char *)"my key"; */
/*   size_t key_len = strlen((const char *)key); */

/*   unsigned char *out=ami_rc4_do(&rc4, key, key_len, (unsigned char *)"this string", 11); */
/*   printf("out:%s\n", ami_rc4_to_hex(out, 11)); */
  
/*   unsigned char *dec=ami_rc4_do(&rc4, key, key_len, out, 11); */
/*   printf("decrypted:%s\n", dec); */
  
/*   free(out); */
  
/*   return 0;     */
/* } */
