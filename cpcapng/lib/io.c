#include <stdio.h>
#include <stdlib.h>
#include <string.h>

#include <cpcapng/blocks.h>

#include <cpcapng/io.h>

int foreach_pcapng_block(uint32_t block_counter, uint32_t block_type, uint32_t block_total_length, unsigned char *data, void *userdata)
{

	switch (block_type) {
	case PCAPNG_SECTION_HEADER_BLOCK: {
		/* printf("Section Header Block\n"); */
		pcapng_section_header_block_light_t *shb;
		shb = cpcapng_section_header_block_read(data, block_total_length);
	}
		break;
	case PCAPNG_CUSTOM_DATA_BLOCK: {
		/* printf("Custom Data Block\n"); */
		pcapng_custom_data_block_light_t *cb;
		cb = cpcapng_custom_data_block_read(data, block_total_length);
	}
		break;
	case PCAPNG_ENHANCED_PACKET_BLOCK: {
		/* printf("PCAPNG_ENHANCED_PACKET_BLOCK\n"); */
		pcapng_enhanced_packet_block_light_t *epb;
		epb = cpcapng_enhanced_packet_block_read(data, block_total_length);
	}
		break;
	case PCAPNG_INTERFACE_DESCRIPTION_BLOCK:
		printf("Interface Description Block\n");
		break;
	default:
		fprintf(stderr, "Block type %x not handled yet!\n", block_type);
		break;
	}

	return 0;
}

int cpcapng_fp_read(FILE *fp, foreach_pcapng_block_cb pcapng_block_cb, void *userdata)
{
	uint64_t block_counter = 1;
	uint32_t block_info[2]; // [0] = block_type [1] = block_total_length
	size_t read_length;

	unsigned char data[65535]; // A packet is not greater than snaplen
	uint32_t block_total_length = 0;

	if (!pcapng_block_cb) {
	  fprintf(stderr, "No Block Callback set!\n");
	  return -1;
	}
	
	read_length = fread(&block_info, 1, PCAPNG_BLOCK_TYPE_AND_SIZE_LENGTH, fp);
	if (read_length != PCAPNG_BLOCK_TYPE_AND_SIZE_LENGTH) {
		fprintf(stderr, "Could not read expected data: got %u expected %u. Stopping.\n", read_length, PCAPNG_BLOCK_TYPE_AND_SIZE_LENGTH);
		return -1;
	}
	block_total_length = block_info[1];
	while (read_length > 0) {
		read_length = fread(&data, 1, block_total_length - PCAPNG_BLOCK_TYPE_AND_SIZE_LENGTH, fp);
		if (read_length != block_info[1] - PCAPNG_BLOCK_TYPE_AND_SIZE_LENGTH) {
			fprintf(stderr, "Could not read expected (%u) block_size; Got %u. Stopping.\n", block_info[1], read_length);
			return -1;
		}

		pcapng_block_cb(block_counter, block_info[0], block_info[1], (unsigned char *)data, (void *)userdata);

		read_length = fread(&block_info, 1, PCAPNG_BLOCK_TYPE_AND_SIZE_LENGTH, fp);
		if (read_length == 0) {
			break;
		}
		if (read_length != PCAPNG_BLOCK_TYPE_AND_SIZE_LENGTH) {
			fprintf(stderr, "Could not read expected (%d) data; Got %u. Stopping.\n", PCAPNG_BLOCK_TYPE_AND_SIZE_LENGTH, read_length);
			return -1;
		}
		block_total_length = block_info[1];

		block_counter++;
	}
}

int cpcapng_file_read(char *filename, foreach_pcapng_block_cb pcapng_block_cb, void *userdata)
{
	FILE *fp;

	fp = fopen(filename, "rb");
	if (!fp) {
		fprintf(stderr, "Cannot read file '%s'\n", filename);
		return -1;
	}

	cpcapng_fp_read(fp, pcapng_block_cb, userdata);

	fclose(fp);
	
	return 0;
}

int cpcapng_file_read_debug(char *filename)
{
  return cpcapng_file_read(filename, foreach_pcapng_block, NULL);
}

