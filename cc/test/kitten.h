#ifndef _CC_TEST_KITTEN_H
#define _CC_TEST_KITTEN_H

#include <string>

class Kitten {
  // Represents a single kitten. Aww!
public:
  Kitten();
  Kitten(const std::string& name, int age);

  // Getters and setters would normally be unnecessary fussy for a class like
  // this, but they give ThinLTO something to do.
  const std::string& Name() const;
  void Rename(const std::string& new_name);
  int Age() const;
  void SetAge(int new_age);

protected:
  std::string name_;
  int age_;
};

#endif  // _CC_TEST_KITTEN_H
