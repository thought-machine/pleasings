import unittest
import filecmp

class templateTests(unittest.TestCase):
    def test_yaml(self):
        self.assertTrue(filecmp.cmp("template/test/expected.yaml", "generated.yaml"))



if __name__ == "__main__":
    unittest.main()
