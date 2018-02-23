CC=gcc
CFLAGS=-Wall -shared -fPIC -lxcb -lxcb-xrm -I .

all: build53

build51:
	$(CC) $(CFLAGS) -I/usr/include/lua5.1 -llua5.1 -o xresources51.so xresources.c

build52:
	$(CC) $(CFLAGS) -I/usr/include/lua5.2 -llua5.2 -o xresources52.so xresources.c

build53:
	$(CC) $(CFLAGS) -llua5.3 -o xresources53.so xresources.c
