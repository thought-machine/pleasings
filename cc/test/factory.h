#ifndef _CC_TEST_FACTORY_H
#define _CC_TEST_FACTORY_H

#include <string>
#include "cc/test/cat.h"

// Supplies a new cat of the given name.
Cat* CanHazCat(const std::string& name);

#endif  // _CC_TEST_FACTORY_H
