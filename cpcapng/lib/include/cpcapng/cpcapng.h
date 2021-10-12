#ifndef _CPCAPNG_H_
#define _CPCAPNG_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

#define SWAP32(x) ((((x) & 0x000000ff) << 24) | (((x) & 0x0000ff00) << 8) | (((x) & 0x00ff0000) >>  8) | (((x) & 0xff000000) >> 24))
#define PADDING(x, aligned_ptr, size) do {\
		*aligned_ptr = (x % size) == 0 ? x : (x / size + 1) * size; \
	} while(0)

#define PCAPNG_VERSION_MAJOR 1
#define PCAPNG_VERSION_MINOR 0

#define PCAPNG_BYTE_ORDER_MAGIC 0x1A2B3C4D

#ifdef __cplusplus
}
#endif

#endif // _CPCAPNG_H_
