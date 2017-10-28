#include "cc/test/family.h"

Family::Family(const Cat& mother, const Cat& father, const Litter& kittens):
    mother_(mother), father_(father), kittens_(kittens) {}

const Cat& Family::Mother() const {
  return mother_;
}

const Cat& Family::Father() const {
  return father_;
}

const Litter& Family::Kittens() const {
  return kittens_;
}
