subinclude("//js:yarn")

# Foo just exports a single function to get the lodash version it's using. This is used by bar_bin to demonstrate how
# node modules can transitively depend on each-others third_party deps
node_module(
    name = "foo_lib",
    deps = ["//js/yarn_workspace_example/foo_lib/src"],
    visibility = ["//js/yarn_workspace_example/..."],
)
