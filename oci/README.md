# OCI Images

There are 3 approaches to containers in Please:
1) Generate .sh files to run `docker build` against a docker context tarball (///pleasings//docker)
2) Build up OCI images by creating our own layers in please build rules (https://github.com/tcncloud/please.containers)
3) Build OCI containers, optionally using Dockerfiles, using buildah and podman (https://github.com/containers/buildah)

These rules aim for the last option. They're less mature than the first option but allow the use of Dockerfiles while
still building the container images at build time.

## A disclaimer about build directories

Buildah creates folders in namespaces that Please doesn't have permissions to delete. These rules try their best to
clean up after themselves however they may still leave files and folders on disk if the build action terminates midway
through. For this reason, these files and folders and created under `/tmp` so they will be cleaned up on system
restarts. This breaks one of the core tenets of Please: don't access files outside the build directory. If this is a
concern for you, then I recommend investigating one of the other two options above.

## Why?

- Docker has disadvantages for building containers with please. It must be run as root and is an external daemon with
  its own state that prevents hermetic incremental builds. The docker rules just produce a .sh file to push the images
  docker which must be ran subsequently.
- OCI images are supported by docker but also other container engines, giving more flexibility whilst also being
  backwards compatible.
- Moving away from docker allows us to follow the unix philosophy with many smaller tools doing one thing well. i.e.
  buildah, skopeo, podman, cri-o etc.
- Using these tools means that images can be built by Please, so can then be cached as artefacts like any other. We can't
  cache images in please without duplicating layers in large tarballs.

## What?

- Adds a container_image() rule that is almost backwards compatible with the docker_image() rule, except that it does
  not assume that you want to use a dockerfile, so it doesn't default to dockerfile="Dockerfile". You also need to
  specify transitive base images.
- Uses buildah to build images and skopeo to move them around. Neither run as root. You can still use docker to run them
  or use podman instead. Image hashes and artifacts are deterministic, no issues with timestamps etc. please struggles to
  delete the ephemeral image cache due to permissions as it is created by rootless buildah (uid=0 and gid=0) so the
  image cache is a tempdir under /tmp (/tmp on the machine, not the one under plz-out). On the happy path this is
  deleted after each build. Worst case, it is deleted at system restart.
- Adds some examples which also function as tests. The main example is copied from the docker image rule.


## Future work:

- Having to explicitly specify transitive base images, although well worth the remote caching gains, is a bit of a pain.
  Could add a pre-build rule similar to add_dep() but for data instead.
- Investigate improvements on the Please side to delete the temp files created by buildah. Everything is unprivileged so
  in theory, Please should be able to `chown` files and folders before attempting to remove them after running a build
  action.