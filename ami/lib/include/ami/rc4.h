#ifndef _AMI_RC4_H_
#define _AMI_RC4_H_

#ifdef __cplusplus
extern "C" {
#endif

struct _ami_rc4_t {
  unsigned char s[256];
};
typedef struct _ami_rc4_t ami_rc4_t;


unsigned char *ami_rc4_do(ami_rc4_t *rc4, unsigned char *key, size_t key_len, unsigned char *data, size_t data_len);
char *ami_rc4_to_hex(unsigned char *data, size_t data_len);
  
#ifdef __cplusplus
}
#endif

#endif // _AMI_RC4_H_
