// This is a very simple main to test ThinLTO for a cc_binary target.

#include <stdio.h>
#include <memory>

#include "cc/test/families.h"
#include "cc/test/factory.h"


int main(int argc, const char* argv[]) {
  const auto family = TibblesFamily();
  printf("Mother: %s\n", family.Mother().Name().c_str());
  printf("Father: %s\n", family.Father().Name().c_str());
  for (auto kitten : family.Kittens().Kittens()) {
    printf("Kitten: %s, age %d\n", kitten.Name().c_str(), kitten.Age());
  }

  std::unique_ptr<Cat> skimbleshanks(CanHazCat("skimbleshanks"));
  printf("Railway cat: %s\n", skimbleshanks->Name().c_str());
  std::unique_ptr<Cat> mister(CanHazCat("mister"));
  try {
    mister->Rename("miss");
    return 1;  // shouldn't get here
  } catch (std::exception& err) {
    printf("threw as expected: %s\n", err.what());
  }

  return 0;
}
