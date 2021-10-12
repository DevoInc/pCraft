#ifndef _CPCAPNG_BLOCKS_H_
#define _CPCAPNG_BLOCKS_H_

#ifdef __cplusplus
extern "C" {
#endif

#include <stdint.h>

#define BLOCK_TOTAL_LENGTH_SIZE 4

#define PCAPNG_INTERFACE_DESCRIPTION_BLOCK         0x00000001
#define PCAPNG_PACKET_BLOCK                        0x00000002
#define PCAPNG_SIMPLE_PACKET_BLOCK                 0x00000003
#define PCAPNG_NAME_RESOLUTION_BLOCK               0x00000004
#define PCAPNG_INTERFACE_STATISTICS_BLOCK          0x00000005
#define PCAPNG_ENHANCED_PACKET_BLOCK               0x00000006
#define PCAPNG_IRIG_TIMESTAMP_BLOCK                0x00000007
#define PCAPNG_ARINC_429_AFDX_ENCAP_BLOCK          0x00000008
#define PCAPNG_SYSTEMD_JOURNAL_EXPORT_BLOCK        0x00000009
#define PCAPNG_DECRYPTION_SECRETS_BLOCK            0x0000000A
#define PCAPNG_HONE_PROJECT_MACHINE_INFO_BLOCK     0x00000101
#define PCAPNG_HONE_PROJECT_CONNECTION_EVENT_BLOCK 0x00000102
#define PCAPNG_SYSDIG_MACHINE_INFO_BLOCK           0x00000201
#define PCAPNG_SYSDIG_PROCESS_INFO_V1_BLOCK        0x00000202
#define PCAPNG_SYSDIG_FD_LIST_BLOCK                0x00000203
#define PCAPNG_SYSDIG_EVENT_BLOCK                  0x00000204
#define PCAPNG_SYSDIG_INTERFACE_LIST_BLOCK         0x00000205
#define PCAPNG_SYSDIG_USER_LIST_BLOCK              0x00000206
#define PCAPNG_SYSDIG_PROCESS_INFO_V2_BLOCK        0x00000207
#define PCAPNG_SYSDIG_EVENT_WITH_FLAGS_BLOCK       0x00000208
#define PCAPNG_SYSDIG_PROCESS_INFO_V3_BLOCK        0x00000209
#define PCAPNG_SYSDIG_PROCESS_INFO_V4_BLOCK        0x00000210
#define PCAPNG_SYSDIG_PROCESS_INFO_V5_BLOCK        0x00000211
#define PCAPNG_SYSDIG_PROCESS_INFO_V6_BLOCK        0x00000212
#define PCAPNG_SYSDIG_PROCESS_INFO_V7_BLOCK        0x00000213
#define PCAPNG_CUSTOM_DATA_BLOCK                   0x00000BAD
#define PCAPNG_CUSTOM_DATA_BLOCK_NOCOPY            0x40000BAD
#define PCAPNG_SECTION_HEADER_BLOCK                0x0A0D0D0A

#define PCAPNG_TLS_KEY_LOG 0x544c534b
#define PCAPNG_WIREGUARD_KEY_LOG 0x57474b4c
#define PCAPNG_ZIGBEE_NWK_KEY 0x5a4e574b
#define PCAPNG_ZIGBEE_APS_KEY 0x5a415053

/*  */

struct _pcapng_custom_data_block_t {
	uint32_t block_type;
	uint32_t block_total_length;
	uint32_t pen;
} __attribute__((packed));
typedef struct _pcapng_custom_data_block_t pcapng_custom_data_block_t;

struct _pcapng_custom_data_block_light_t {
	uint32_t pen;
} __attribute__((packed));
typedef struct _pcapng_custom_data_block_light_t pcapng_custom_data_block_light_t;

struct _pcapng_section_header_block_t {
	uint32_t block_type;
	uint32_t block_total_length;
	uint32_t magic;
	uint16_t major_version;
	uint16_t minor_version;
	uint64_t section_length;
} __attribute__((packed));
typedef struct _pcapng_section_header_block_t pcapng_section_header_block_t;

struct _pcapng_section_header_block_light_t {
	uint32_t magic;
	uint16_t major_version;
	uint16_t minor_version;
	uint64_t section_length;
} __attribute__((packed));
typedef struct _pcapng_section_header_block_light_t pcapng_section_header_block_light_t;

struct _pcapng_interface_description_block_t {
	uint32_t block_type;
	uint32_t block_total_length;
	uint16_t linktype;
	uint16_t reserved;
	uint32_t snaplen;
} __attribute__((packed));
typedef struct _pcapng_interface_description_block_t pcapng_interface_description_block_t;

struct _pcapng_interface_description_block_light_t {
	uint16_t linktype;
	uint16_t reserved;
	uint32_t snaplen;
} __attribute__((packed));
typedef struct _pcapng_interface_description_block_light_t pcapng_interface_description_block_light_t;

struct _pcapng_enhanced_packet_block_t {
	uint32_t block_type;
	uint32_t block_total_length;
	uint32_t interface_id;
	uint32_t timestamp_high;
	uint32_t timestamp_low;
	uint32_t captured_packet_length;
	uint32_t original_packet_length;
} __attribute__((packed));
typedef struct _pcapng_enhanced_packet_block_t pcapng_enhanced_packet_block_t;

struct _pcapng_enhanced_packet_block_light_t {
	uint32_t interface_id;
	uint32_t timestamp_high;
	uint32_t timestamp_low;
	uint32_t captured_packet_length;
	uint32_t original_packet_length;
} __attribute__((packed));
typedef struct _pcapng_enhanced_packet_block_light_t pcapng_enhanced_packet_block_light_t;

size_t cpcapng_section_header_block_write(unsigned char *outbuf);
size_t cpcapng_section_header_block_size(void);
pcapng_section_header_block_light_t *cpcapng_section_header_block_read(unsigned char *inbuf, size_t inbuf_len);
size_t cpcapng_interface_description_block_write(uint32_t snaplen, unsigned char *outbuf);
size_t cpcapng_interface_description_block_size(void);
pcapng_interface_description_block_light_t *cpcapng_interface_description_block_read(unsigned char *inbuf, size_t inbuf_len);
size_t cpcapng_enhanced_packet_block_write(const unsigned char *packet, const size_t packet_len, unsigned char *outbuf);
size_t cpcapng_enhanced_packet_block_size(const size_t packet_len);
pcapng_enhanced_packet_block_light_t *cpcapng_enhanced_packet_block_read(unsigned char *inbuf, size_t inbuf_len);
size_t cpcapng_custom_data_block_write(const uint32_t pen, const unsigned char *data, const size_t data_len, unsigned char *outbuf);
size_t cpcapng_custom_data_block_size(const size_t data_len);
pcapng_custom_data_block_light_t *cpcapng_custom_data_block_read(unsigned char *inbuf, size_t inbuf_len);

#ifdef __cplusplus
}
#endif

#endif	/* _CPCAPNG_BLOCKS_H_ */
