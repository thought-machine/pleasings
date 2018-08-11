// Main file for UnitTest++-based tests.
// This is typically fetched via subrepo, but could also be vendored if preferred.
//
// N.B. This requires at least a C++11 compiler. It could be rewritten for older versions
//      if needed, but it's probably not worth the effort in this day and age.

#include <algorithm>
#include <fstream>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <vector>

#include "UnitTest++/UnitTest++.h"
#include "UnitTest++/XmlTestReporter.h"

int main(int argc, const char** argv) {
    if (getenv("DEBUG")) {
        unsetenv("DEBUG");
        std::vector<char*> v({strdup("gdb"), strdup("-ex"), strdup("run"), strdup("--args")});
        v.insert(v.end(), const_cast<char**>(argv), const_cast<char**>(argv) + argc);
        execvp("gdb", const_cast<char**>(&v[0]));
    }
    // This implements filtering tests to just those named in command-line arguments.
    auto run_named = [argc, argv](UnitTest::Test* test) {
        return argc <= 1 || std::any_of(argv + 1, argv + argc, [test](const char* name) {
            return strcmp(test->m_details.testName, name) == 0;
        });
    };

    std::ofstream f("test.results");
    if (!f.good()) {
      fprintf(stderr, "Failed to open results file\\n");
      return -1;
    }
    if (getenv("COVERAGE")) {
      // This is just a placeholder. Actual coverage is written via gcc magic, plz
      // knows how to interpret this file and read the real gcov files.
      std::ofstream c("test.coverage");
      c << "gcov";
    }
    UnitTest::XmlTestReporter reporter(f);
    UnitTest::TestRunner runner(reporter);
    return runner.RunTestsIf(UnitTest::Test::GetTestList(), NULL, run_named, 0);
}
