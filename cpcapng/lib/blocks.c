#include <sys/time.h>
#include <stdlib.h>
#include <string.h>
#include <stdio.h>

#include <cpcapng/cpcapng.h>
#include <cpcapng/linktypes.h>

#include <cpcapng/blocks.h>

size_t cpcapng_section_header_block_write(unsigned char *outbuf)
{
	size_t block_total_length;
	uint32_t *final_length;
	pcapng_section_header_block_t *shb;

	block_total_length = cpcapng_section_header_block_size();

	shb = (pcapng_section_header_block_t *)outbuf;
	shb->block_type = PCAPNG_SECTION_HEADER_BLOCK;
	shb->block_total_length = block_total_length;
	shb->magic = PCAPNG_BYTE_ORDER_MAGIC;
	shb->major_version = PCAPNG_VERSION_MAJOR;
	/* shb->minor_version = PCAPNG_VERSION_MINOR; */
	shb->section_length = 0;

	final_length = (uint32_t *)(outbuf+block_total_length - BLOCK_TOTAL_LENGTH_SIZE);
	*final_length = block_total_length;

	return block_total_length;
}

size_t cpcapng_section_header_block_size(void)
{
	return sizeof(pcapng_section_header_block_t) + BLOCK_TOTAL_LENGTH_SIZE;
}

pcapng_section_header_block_light_t *cpcapng_section_header_block_read(unsigned char *inbuf, size_t inbuf_len)
{
	pcapng_section_header_block_light_t *shb;

	shb = (pcapng_section_header_block_light_t *)inbuf;

	return shb;
}

size_t cpcapng_interface_description_block_write(uint32_t snaplen, unsigned char *outbuf)
{
	size_t block_total_length;
	uint32_t *final_length;
	pcapng_interface_description_block_t *idb;

	block_total_length = cpcapng_interface_description_block_size();

	idb = (pcapng_interface_description_block_t *)outbuf;
	idb->block_type = PCAPNG_INTERFACE_DESCRIPTION_BLOCK;
	idb->block_total_length = block_total_length;
	idb->linktype = LINKTYPE_RAW;
	idb->reserved = 0;
	idb->snaplen = snaplen;

	final_length = (uint32_t *)(outbuf + block_total_length - BLOCK_TOTAL_LENGTH_SIZE);
	*final_length = block_total_length;

	return block_total_length;
}

size_t cpcapng_interface_description_block_size(void)
{
	return sizeof(pcapng_interface_description_block_t) + BLOCK_TOTAL_LENGTH_SIZE;
}

size_t cpcapng_enhanced_packet_block_write_time(const unsigned char *packet, const size_t packet_len, uint32_t timestamp_high, uint32_t timestamp_low, unsigned char *outbuf)
{
	size_t block_total_length;
	uint32_t *final_length;
	pcapng_enhanced_packet_block_t *epb;

	block_total_length = cpcapng_enhanced_packet_block_size(packet_len);

	epb = (pcapng_enhanced_packet_block_t *)outbuf;
	epb->block_type = PCAPNG_ENHANCED_PACKET_BLOCK;
	epb->block_total_length = block_total_length;
	epb->interface_id = 0;

	epb->timestamp_high = timestamp_high;
	epb->timestamp_low = timestamp_low;

	epb->captured_packet_length = packet_len;
	epb->original_packet_length = packet_len;

	memcpy(outbuf + sizeof(pcapng_enhanced_packet_block_t), packet, packet_len);

	final_length = (uint32_t *)  (outbuf + block_total_length - BLOCK_TOTAL_LENGTH_SIZE);
	*final_length = block_total_length;

	return block_total_length;
}

size_t cpcapng_enhanced_packet_block_write(const unsigned char *packet, const size_t packet_len, unsigned char *outbuf)
{
	struct timeval tv;
	uint64_t ms_tv = 0;
	uint32_t timestamp_high;
	uint32_t timestamp_low;
	
	gettimeofday(&tv, NULL);
	ms_tv = (uint64_t) (tv.tv_sec) * (uint64_t) 1e6 + (uint64_t) (tv.tv_usec);

	timestamp_high = (uint32_t) (ms_tv >> 32);
	timestamp_low = (uint32_t) ms_tv;

	return cpcapng_enhanced_packet_block_write_time(packet, packet_len, timestamp_high, timestamp_low, outbuf);
}

size_t cpcapng_enhanced_packet_block_size(const size_t packet_len)
{
	uint32_t padded_len;
	uint32_t padding;

	PADDING(packet_len, &padded_len, sizeof(uint32_t));
	padding = padded_len - packet_len;

	return sizeof(pcapng_enhanced_packet_block_t) + packet_len + padding + BLOCK_TOTAL_LENGTH_SIZE;
}

pcapng_enhanced_packet_block_light_t *cpcapng_enhanced_packet_block_read(unsigned char *inbuf, size_t inbuf_len)
{

}

size_t cpcapng_custom_data_block_write(const uint32_t pen, const unsigned char *data, const size_t data_len, unsigned char *outbuf)
{
	size_t block_total_length;
	uint32_t *final_length;
	pcapng_custom_data_block_t *cb;

	block_total_length = cpcapng_custom_data_block_size(data_len);

	memset(outbuf, 0, block_total_length);
	cb = (pcapng_custom_data_block_t *)outbuf;
	cb->block_type = PCAPNG_CUSTOM_DATA_BLOCK;
	cb->block_total_length = block_total_length;
	cb->pen = pen;

	memcpy(outbuf + sizeof(pcapng_custom_data_block_t), data, data_len);

	final_length = (uint32_t *) (outbuf + block_total_length - BLOCK_TOTAL_LENGTH_SIZE);
	*final_length = block_total_length;

#ifdef DEBUG
	uint32_t i;
	printf("Custom Packet Hex output:\n");
	for (i = 0; i < data_len; i++) {
	  printf("%02X", data[i]);
	}
	printf("\n");
#endif // DEBUG	
	
	return block_total_length;
}

size_t cpcapng_custom_data_block_size(const size_t data_len)
{
	uint32_t padded_len;
	uint32_t padding;

	PADDING(data_len, &padded_len, sizeof(uint32_t));
	padding = padded_len - data_len;

	return sizeof(pcapng_custom_data_block_t) + data_len + padding + BLOCK_TOTAL_LENGTH_SIZE;
}

uint32_t cpcapng_custom_data_block_start_offset(void)
{
  return sizeof(pcapng_custom_data_block_light_t);
}

uint32_t cpcapng_custom_data_block_data_length(uint32_t block_total_length)
{
  uint32_t retlen = block_total_length;
  retlen -= BLOCK_TOTAL_LENGTH_SIZE; // The First one.
  retlen -= sizeof(uint32_t); // The block type
  retlen -= cpcapng_custom_data_block_start_offset();
  retlen -= BLOCK_TOTAL_LENGTH_SIZE; // The last one.

  return retlen;
}

pcapng_custom_data_block_light_t *cpcapng_custom_data_block_read(unsigned char *inbuf, size_t inbuf_len)
{

	return NULL;
}
