CC=gcc
CFLAGS=-I../ami/lib/include/ -ggdb
LIBS=-L../ami/build/lib/ -lami -lavro

all: ccraft read

ccraft: ccraft.c ccraft.h
	$(CC) $^ $(CFLAGS) $(LIBS) -o $@

read: read.c ccraft.h
	$(CC) $^ $(CFLAGS) $(LIBS) -o $@

