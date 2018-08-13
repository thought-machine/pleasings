#include "cc/test/cat.h"

using std::string;

// Arbitrarily this is a default age. That's just how it works.
const int kDefaultAge = 7;

Cat::Cat() {}
Cat::Cat(const string& name): Kitten(name, kDefaultAge) {}
Cat::Cat(const string& name, int age): Kitten(name, age) {}

bool Cat::WouldTriumphAgainst(const Cat& cat) const {
  // The rules of the cat hierarchy are somewhat complex...
  // 1. Cats never win against themselves (see /r/catsvsthemselves for proof)
  if (Name() == cat.Name()) {
    return false;
  }
  // 2. Greebo would never take on You.
  if (Name() == "Greebo" && cat.Name() == "You") {
    return false;
  }
  // 3. But otherwise he always wins, against anything up to a mountain lion
  if (Name() == "Greebo") {
    return true;
  } else if (cat.Name() == "Greebo") {
    return false;
  }
  // 4. Mister wins otherwise. He'd probably get +1 from Bob but we don't really
  //    have a way to represent that in this class hierachy...
  if (Name() == "Mister") {
    return true;
  } else if (cat.Name() == "Mister") {
    return false;
  }
  // 5. Add some more cats here?
  return Name() < cat.Name();
}
