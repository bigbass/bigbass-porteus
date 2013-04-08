CC = gcc

CFLAGS = -Wall				\
	-DG_DISABLE_DEPRECATED	\
	-DGDK_DISABLE_DEPRECATED	\
	-DGDK_PIXBUF_DISABLE_DEPRECATED

switch-c: switch-c.c
	$(CC) switch-c.c -o switch.c $(CFLAGS) `pkg-config gtk+-3.0 --cflags --libs`

clean:
	rm -f switch-c
