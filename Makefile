PONYRT_INCLUDE=~/src/pony/ponyc/src/libponyrt/
PONYRT_LIB=~/src/pony/ponyc/build/release/libponyrt.a

all: test

libclib.a clib.h: clib/main.pony
	ponyc -l clib

test: test.c clib.h libclib.a
	gcc -o test -I. -I $(PONYRT_INCLUDE) -g -mcx16 test.c libclib.a $(PONYRT_LIB) -lpthread -ldl
