#ifndef _CPCAPNG_IO_H_
#define _CPCAPNG_IO_H_

#include <stdint.h>

#ifdef __cplusplus
extern "C" {
#endif

#define PCAPNG_BLOCK_TYPE_AND_SIZE_LENGTH 8 // sizeof(uint32_t) * 2

typedef int (*foreach_pcapng_block_cb)(uint32_t block_counter, uint32_t block_type, uint32_t block_total_length, unsigned char *data);

int cpcapng_file_read(char *filename, foreach_pcapng_block_cb pcapng_block_cb);
int cpcapng_file_read_debug(char *filename);

#ifdef __cplusplus
}
#endif

#endif // _CPCAPNG_IO_H_
