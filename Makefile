PONYRT_INCLUDE=~/src/pony/ponyc/src/libponyrt/
PONYRT_COMMON=~/src/pony/ponyc/src/common
PONYRT_LIB=~/src/pony/ponyc/build/release/libponyrt.a

all: test

libclib.a clib.h: clib/main.pony
	ponyc -l clib

test: test.c clib.h libclib.a
	gcc -rdynamic -o test -I. -I $(PONYRT_INCLUDE) -I $(PONYRT_COMMON) -g -mcx16 test.c libclib.a $(PONYRT_LIB) -lpthread -ldl

clean:
	-rm -f libclib.a
	-rm -f clib.h
	-rm -f test
