// Very simple test file to debug losing vtables.

#include <stdio.h>
#include "cc/test/kitten.h"

int main(int argc, char** argv) {
  Kitten kitten = Kitten("Mister", 5);
  printf("%s\n", kitten.Name().c_str());
  return 0;
}
