#include "cc/test/families.h"

#include "cc/test/cat.h"
#include "cc/test/kitten.h"
#include "cc/test/litter.h"

Family TibblesFamily() {
  return Family(Cat("Mrs. Tibbles"), Cat("Mr. Tibbles"), Litter({
        Kitten("Mighty Paws", 2),
        Kitten("Speedy Hunter", 1),
  }));
}
