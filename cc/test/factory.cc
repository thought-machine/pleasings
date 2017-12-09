#include "cc/test/factory.h"

#include <stdexcept>

namespace {

class CatasaurusRex : public Cat {
 public:
  CatasaurusRex(): Cat("Mister", 2) {}

  void Rename(const std::string& new_name) override {
    throw std::runtime_error("cannot rename this cat");
  }
};

}

Cat* CanHazCat(const std::string& name) {
  if (name == "Mister") {
    return new CatasaurusRex();
  }
  return new Cat(name, 2);
}
