#ifndef _CC_TEST_FAMILY_H
#define _CC_TEST_FAMILY_H

#include "cc/test/cat.h"
#include "cc/test/litter.h"

class Family {
  // Models a feline family. Awww!
public:
  Family(const Cat& mother, const Cat& father, const Litter& kittens);

  const Cat& Mother() const;
  const Cat& Father() const;
  const Litter& Kittens() const;

protected:
  const Cat mother_;
  const Cat father_;
  const Litter kittens_;
};

#endif  // _CC_TEST_FAMILY_H
