CC=gcc
CFLAGS=-I/usr/include/SDL2 -lSDL2

all: deskres

deskres:
	$(CC) $(CFLAGS) -o deskres.bin deskres.c

clean:
	[[ -f deskres.bin ]] && rm deskres.bin
