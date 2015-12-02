Compiling Pony to a library and linking to C
============================================

The [Pony Programming Language](http://ponylang.org/) compiler can generate
a C header and library for linking to C programs. This project is a short
example of how this works.

In Pony you create an `actor@` that can be used from C:

    actor@ Foo
      new create() =>
        None
    
      be hi() =>
        @printf[I32]("Hi\n".cstring())

Compile with:

    $ ponyc -l clib

This produces a `clib.h` and a `libclib.a`. The header file contains
definitions to create and call the behaviours in the actor:

    /* Allocate a Foo without initialising it. */
    Foo* Foo_Alloc();
    
    Foo* Foo_hi__send(Foo* self);
    
    Foo* Foo_create__send(Foo* self);

The [ponyc](https://github.com/CausalityLtd/ponyc) compiler source has
a header file, [pony.h](https://github.com/CausalityLtd/ponyc/blob/master/src/libponyrt/pony.h) with
definitions for interacting with the Pony runtime from C program. The basic
approach is to initialize the runtime, create some actors and call methods, then start the scheduler:

    int main(int argc, char** argv) {
      pony_init(argc, argv);
      Foo* x = Foo_Alloc();
      Foo_create__send(x);
      Foo_hi__send(x);
      pony_start(0);
      return 0;
    }

There are other runtime functions that allow you to create Pony objects outside
of the scheduler. It's possible to allocate an actor, 'unschedule' it, and then
use a C thread to handle its message queue using `pony_become`. When you aren't
handling messages to the unscheduled actor you can call functions to it from C
with no race conditions.

Thanks to `sylvanc` on IRC for explaining how the API is used and fixing issues to
get the example working.
