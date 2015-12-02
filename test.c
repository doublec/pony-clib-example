#include <stdio.h>
#include "clib.h"
#include "pony.h"

int main(int argc, char** argv) {

  pony_init(argc, argv);

  Foo* x = Foo_Alloc();
  Foo_create__send(x);
  Foo_hi__send(x);

  pony_start(1);
//  pony_register_thread();

  Foo* y = Foo_Alloc();
  Foo_create__send(y);
  Foo_hi__send(y);
  pony_stop();
  return 0;
}
