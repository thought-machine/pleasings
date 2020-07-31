#!/usr/bin/python3
"""Module to take yarn's output and rewrite it into BUILD rules.

N.B. Deps probably need to be installed with --flat for now.

TODO(peterebden): Rewrite this in Javascript...

N.B. this is designed to work with the rules in //js:js not the new rules in //js:yarn.

Usage:
  yarn list --json | yarn_deps.py >> third_party/js/BUILD
"""

import json
import sys


NO_DEPS_TEMPLATE = """
yarn_library(
    name = '%s',
    version = '%s',
)
"""


DEPS_TEMPLATE = """
yarn_library(
    name = '%s',
    version = '%s',
    deps = [
%s    ],
)
"""


def parse_name(item):
    name, _, version = item['name'].partition('@')
    return name


def read_deps(items):
    for item in items:
        name, _, version = item['name'].partition('@')
        deps = [parse_name(child) for child in item.get('children', [])]
        yield name, (version, deps)


def fix_deps(name, data, seen=frozenset()):
    seen = seen | {name}
    version, deps = data[name]
    deps = [fix_deps(dep, data, seen) for dep in deps if dep not in seen]
    data[name] = (version, deps)
    return name


def main():
    data = json.load(sys.stdin)
    items = dict(read_deps(data['data']['trees']))
    # This is a little ugly; we need to restrict circular dependencies, which means we have to do
    # it top-down, but the only thing giving us reliable information about where the top of the
    # tree is is the color property.
    for item in data['data']['trees']:
        if item.get('color') == 'bold':
            fix_deps(parse_name(item), items)
    for name, (version, deps) in sorted(items.items()):
        if deps:
            sys.stdout.write(DEPS_TEMPLATE % (name, version, ''.join("        ':%s',\n" % dep for dep in deps)))
        else:
            sys.stdout.write(NO_DEPS_TEMPLATE % (name, version))


if __name__ == '__main__':
    main()
