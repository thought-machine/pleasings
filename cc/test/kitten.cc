#include "cc/test/kitten.h"

using std::string;

Kitten::Kitten(): age_(0) {}
Kitten::Kitten(const string& name, int age): name_(name), age_(age) {}

const string& Kitten::Name() const {
  return name_;
}

void Kitten::Rename(const string& new_name) {
  name_ = new_name;
}

int Kitten::Age() const {
  return age_;
}

void Kitten::SetAge(int new_age) {
  age_ = new_age;
}
