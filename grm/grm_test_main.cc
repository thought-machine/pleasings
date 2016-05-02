// This is a simple tool for testing thrax grammars. It is based on
// thraxrewrite_tester written by Terry Tai and Richard Sproat.
//
// thrax_test is intended as an easy way to run regression tests on
// finite state transducers (FSTs) built from thrax grammars.
// It works by taking input from stdin of the form:
//
// RULE	input	reference
//
// Where the fields are separated by some separator character, by
// default tab but is configurable. For example
//
// FORMAT_MONEY^108930^$108,930
//
// The input file has one test per line.
//
// It runs an FST by name, which has been exported and compiled
// from a thrax .grm file. The FST processes the input string,
// generates an output string, and compares to the reference. If the
// strings differ, this is printed to stdout. If the same, no output
// is generated. Hence if the output exactly matches the input for
// every test, the program prints nothing.
//
// The program runs on an FST archive file. This is created from the
// grm file by the thraxcompiler tool, which is part of the open
// source thrax distribution.
//
// Usage:
// grm_test --far=example.far < example.ref
//
// Authors: Paul Taylor <paul@thoughtmachine.net>
//          Peter Ebden <pebers@thoughtmachine.net>

#include <fstream>
#include <iostream>
#include <set>
#include <stdio.h>
#include <string>

#include <thrax/grm-manager.h>

using fst::StdArc;
typedef thrax::GrmManagerSpec<StdArc> GrmManager;
typedef fst::VectorFst<StdArc> VectorFst;
typedef StdArc::Weight Weight;
using std::cerr;
using std::cin;
using std::getline;
using std::endl;

#define PrintIfOpen(f, ...) if (f) fprintf(f, __VA_ARGS__)

DEFINE_string(rule, "", "Test using this rule name. Ignore the rule name specified at the start of the line");
DEFINE_string(exclude, "", "File containing line numbers of tests to exclude, for unit testing purposes");
DEFINE_string(separator, "\t", "Separating character for fields in the reference file");
DEFINE_string(far, "", "Path to the FAR.");
DEFINE_string(o, "", "Path to a test output file to write.");
DEFINE_bool(ignore_case, false, "Ignore the case of the inputs (NB. not outputs)");

bool ReadInput(string *test_rule, string *input, string *reference, bool *comment,
               const std::set<int> &exclude, int *line_number) {
  string raw_string;

  if (!getline(cin, raw_string)) {
    return false;
  }

  (*line_number)++;

  if (raw_string.empty() || raw_string[0] == '#') {
    *comment = true;
    return true;
  } else {
    *comment = false;
  }

  if (exclude.find(*line_number) != exclude.end()) {
    *comment = true;
    return true;
  }

  const size_t rule_end = raw_string.find(FLAGS_separator);
  const size_t input_text_end = raw_string.rfind(FLAGS_separator);

  if (rule_end == string::npos || input_text_end == string::npos) {
    cerr << "Test lines must be of the form RULE input" << FLAGS_separator << "reference:\n";
    cerr << "  " << raw_string << endl;
    exit(-1);
  }

  *test_rule = FLAGS_rule.empty() ? raw_string.substr(0, rule_end) : FLAGS_rule;
  *input = raw_string.substr(rule_end + 1, input_text_end - rule_end - 1);
  *reference = raw_string.substr(input_text_end + 1, raw_string.size());

  return true;
}

inline size_t find_nth(const std::string& s, char c, int n) {
  size_t pos = 0;
  for (int i = 0; i < n && pos != string::npos; ++i) {
    pos = s.find(c, pos + 1);
  }
  return pos;
}

// Rewrites input to output according to the given grammar rule.
bool Rewrite(const GrmManager& grm, const string& rule, const string& input, string* output) {
  if (!FLAGS_ignore_case) {
    return grm.RewriteBytes(rule, input, output, "");
  }
  // Have to dual-case this guy ourselves.
  VectorFst fst;
  VectorFst::StateId state = fst.AddState();
  fst.SetStart(state);
  for (const char c : input) {
    VectorFst::StateId next_state = fst.AddState();
    fst.AddArc(state, StdArc(c, c, Weight::One(), next_state));
    if (islower(c)) {
      fst.AddArc(state, StdArc(toupper(c), toupper(c), Weight::One(), next_state));
    } else if (isupper(c)) {
      fst.AddArc(state, StdArc(tolower(c), tolower(c), Weight::One(), next_state));
    }
    state = next_state;
  }
  fst.SetFinal(state, Weight::One());
  return grm.RewriteBytes(rule, fst, output, "");
}

int main(int argc, char** argv) {
  SET_FLAGS(argv[0], &argc, &argv, true);

  GrmManager grm;

  CHECK(!FLAGS_far.empty());
  CHECK(grm.LoadArchive(FLAGS_far));

  FILE* output_file = NULL;
  if (FLAGS_o != "") {
    output_file = fopen(FLAGS_o.c_str(), "w");
    CHECK(output_file);
  }

  std::set<int> exclude;

  if (FLAGS_exclude != "") {
    std::string line;
    std::ifstream infile(FLAGS_exclude, std::ios_base::in);
    if (infile.fail()) {
      cerr << "Error: couldn't open file " << FLAGS_exclude.c_str() << endl;
      exit (-1);
    }
    while (getline(infile, line, '\n')) {
        exclude.insert(std::stoi(line));
      }
   }

  bool fail = false, success = false;
  string test_rule, input, output, reference;
  int line = 0;
  bool comment = false;

  while (ReadInput(&test_rule, &input, &reference, &comment, exclude, &line)) {
    if (!comment) {
      // Output is in Go test format because it's easy and convenient and we already parse it.
      PrintIfOpen(output_file, "=== RUN TestLine%d\n", line);
      if (Rewrite(grm, test_rule, input, &output)) {
        if (reference == output) {
          PrintIfOpen(output_file, "--- PASS: TestLine%d (0.00s)\n", line);
          success = true;
        } else {
          printf("Line %d [%s]: Expected [%s] got [%s]\n", line, input.c_str(), reference.c_str(), output.c_str());
          PrintIfOpen(output_file, "--- FAIL: TestLine%d (0.00s)\n    Expected [%s] got [%s]\n",
                      line, reference.c_str(), output.c_str());
          fail = true;
        }
      } else {
        printf("Line %d [%s]: Rewrite failed\n", line, input.c_str());
        PrintIfOpen(output_file, "--- FAIL: TestLine%d (0.00s)\n    Rewrite failed\n", line);
        fail = true;
      }
    }
  }

  if (output_file) {
    if (!fail && !success) {
      // Must print at least one result line
      fprintf(output_file, "=== RUN NoTests\n--- PASS: NoTests (0.00s)\n");
    }
    fprintf(output_file, "%s\n", fail ? "FAIL" : "PASS");
    fclose(output_file);
  }

  return fail ? -1 : 0;
}
