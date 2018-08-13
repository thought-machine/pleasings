#ifndef _CC_TEST_CAT_H
#define _CC_TEST_CAT_H

#include "cc/test/kitten.h"

class Cat : public Kitten {
  // The grown-up version.
  // It's a bit silly to inherit this but it's hardly real code...
public:
  Cat();
  Cat(const std::string& name);  // Creates a cat of arbitrary age
  Cat(const std::string& name, int age);

  // Returns true if this cat could defeat another one in a fight.
  bool WouldTriumphAgainst(const Cat& cat) const;
};

#endif  // _CC_TEST_CAT_H
