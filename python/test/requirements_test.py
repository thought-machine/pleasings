import unittest


class RequirementsTest(unittest.TestCase):

    def test_can_import_six(self):
        import six
        self.assertTrue(six.text_type)

    def test_can_import_attrs(self):
        import attr
        self.assertEqual("18.1.0", attr.__version__)
