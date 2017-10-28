// This is a very simple main to test ThinLTO for a cc_binary target.

#include <stdio.h>

#include "cc/test/families.h"


int main(int argc, const char* argv[]) {
  const auto family = TibblesFamily();
  printf("Mother: %s\n", family.Mother().Name().c_str());
  printf("Father: %s\n", family.Father().Name().c_str());
  for (auto kitten : family.Kittens().Kittens()) {
    printf("Kitten: %s, age %d\n", kitten.Name().c_str(), kitten.Age());
  }
  return 0;
}
