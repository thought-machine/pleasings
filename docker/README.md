Docker build rules
==================

These build defs contain a set of rules for building Docker images
with plz. Unfortunately this is quite tricky since docker commands
operate via side effects whereas plz is a file-based build system.
This is worked around by the actual docker build being done by `plz run`
on the relevant target.

Within the Dockerfile you have access to those files declared as
srcs of it (and only those ones, not anything else in the
same directory).

It's also possible to derive Docker images from one another; you can
set the FROM clause to a build label and set the `base_image` argument
on the build rule to match. They'll be built in sequence.

Images are fingerprinted and tagged using a unique hash based on their
inputs, so they're always identifiable.

In future we will introduce some Kubernetes rules that take advantage of these.
