import unittest
import subprocess

class templateTests(unittest.TestCase):
    def test_yaml():
        self.assertTrue(filecmp.cmp("expected.yaml", "generated.yaml"))



if __name__ == "__main__":
    unittest.main()
