#include <UnitTest++/UnitTest++.h>

#include "cc/test/families.h"
#include "cc/test/cat.h"

TEST(TibblesFamily) {
  const auto tibbles = TibblesFamily();
  CHECK_EQUAL("Mrs. Tibbles", tibbles.Mother().Name());
  CHECK_EQUAL(2, tibbles.Kittens().Kittens().size());
}

TEST(CatHierarchy) {
  const Cat greebo("Greebo");
  const Cat you("You");
  const Cat mister("Mister");
  const Cat slinky_malinki("Slinki Malinki");
  const Cat scarface_claw("Scarface Claw");

  CHECK(!greebo.WouldTriumphAgainst(you));
  CHECK(greebo.WouldTriumphAgainst(scarface_claw));
  CHECK(mister.WouldTriumphAgainst(slinky_malinki));
}
