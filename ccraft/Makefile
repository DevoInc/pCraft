CC=gcc
CFLAGS=-I../ami/lib/include/
LIBS=-L../ami/build/lib/ -lami -lcsv

all: ccraft

ccraft: ccraft.c
	$(CC) $^ $(CFLAGS) $(LIBS) -o $@
