PROGRAMS = namegen

CC = clang++
CFLAGS=-Wall -O2 -std=c++14 -march=native
LIBS=

all: $(PROGRAMS)

.cc: ; $(CC) $(CFLAGS) $@.cc $(LIBS) -o $@
	strip $@

clean:
	rm $(PROGRAMS)
