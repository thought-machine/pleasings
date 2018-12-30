"""Utility for finding upgrades for pip libraries."""

import argparse
import logging
import re
import sys

from third_party.python import pkg_resources
from third_party.python.yolk import pypi, yolklib


def main(pkgs):
    logging.info('Connecting to PyPI...')
    cs = pypi.CheeseShop()
    done = set()
    while pkgs:
        pkg = pkgs.pop()
        done.add(pkg)
        logging.info('Looking for update for %s', pkg)
        name, _, version = pkg.partition('==')
        _, versions = cs.query_versions_pypi(name)
        highest = yolklib.get_highest_version(versions)
        if highest != version:
            # Canonicalise rule names into usual plz style
            rule_name = name.lower().replace('-', '_')
            data = cs.release_data(name, highest)
            licence = data.get('license', '')
            # TODO(peterebden): should really do something with the versions here
            deps = [list(pkg_resources.parse_requirements(dep))[0].project_name
                    for dep in data.get('requires_dist', [])]
            # Add any deps that we haven't processed yet
            pkgs |= {dep for dep in deps if dep not in done}
            print('python_library(')
            print(f'    name = "{rule_name}",')
            print(f'    version = "{highest}",')
            if name != rule_name:
                print(f'    package_name = "{name}",')
            if licence:
                print(f'    licence = "{licence}",')
            if deps:
                print(f'    deps = [')
                print('\n'.join(f'        ":{dep}",' for dep in deps))
            print(')\n')
        else:
            logging.info('%s==%s is already the latest version', name, version)


if __name__ == '__main__':
    parser = argparse.ArgumentParser()
    parser.add_argument('-v', dest='v', action='store_true', help='Verbose mode')
    parser.add_argument('packages', nargs='+', help='Packages to update')
    args = parser.parse_args()
    if args.v:
        logging.getLogger().setLevel(logging.INFO)
    main(set(args.packages))
