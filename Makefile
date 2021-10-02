PROGRAMS = namegen

CC = c++
CFLAGS=-Wall -O2 -std=c++14
LIBS=

all: $(PROGRAMS)

.cc: ; $(CC) $(CFLAGS) $@.cc $(LIBS) -o $@
	strip $@

clean:
	rm $(PROGRAMS)
