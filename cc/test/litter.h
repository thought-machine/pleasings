#ifndef _CC_TEST_LITTER_H
#define _CC_TEST_LITTER_H

#include <initializer_list>
#include <vector>
#include "cc/test/kitten.h"

class Litter {
  // Models a litter of kittens. Awwww!
public:
  Litter();
  Litter(std::initializer_list<Kitten> kittens);

  const std::vector<Kitten>& Kittens() const;
  // Kittens can be added to the litter but cannot be removed.
  // A kitten is for life, after all.
  void AddKitten(const Kitten& kitten);

protected:
  std::vector<Kitten> kittens_;
};

#endif  // _CC_TEST_LITTER_H
