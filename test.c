#include <stdio.h>
#include "clib.h"
#include "pony.h"

int main(int argc, char** argv) {

  pony_init(argc, argv);

  Foo* x = Foo_Alloc();
  Foo_tag_create_o__send(x);
  Foo_tag_hi_o__send(x);

  if (pony_start(true, true) == -1) {
    printf("Failed to start Pony runtime\n");
  }

  Foo* y = Foo_Alloc();
  Foo_tag_create_o__send(y);
  Foo_tag_hi_o__send(y);
  pony_stop();
  return 0;
}
