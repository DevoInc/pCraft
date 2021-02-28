CC=gcc
CFLAGS=-I../ami/lib/include/
LIBS=-L../ami/build/lib/ -lami -lprotobuf-c

PROTOC=protoc-c

all: protoc ccraft

protoc: ccraft.proto3
	$(PROTOC) --c_out=./pbuf $^

ccraft: ccraft.c pbuf/ccraft.proto3.pb-c.c
	$(CC) $^ $(CFLAGS) $(LIBS) -o $@
