#include "cc/test/litter.h"

using std::initializer_list;
using std::vector;

Litter::Litter() {}
Litter::Litter(initializer_list<Kitten> kittens): kittens_(kittens) {}

const vector<Kitten>& Litter::Kittens() const {
  return kittens_;
}

void Litter::AddKitten(const Kitten& kitten) {
  kittens_.push_back(kitten);
}
