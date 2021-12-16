subinclude("//helm")


chart(
  name = "chart",
  chart_name = "mychart",
  repo = "$INTERNAL_SUB_CHART_REPO",
  oci_registry = "$CHART_OCI_REGISTRY",
  oci_registry_username = "$CHART_OCI_REGISTRY_USERNAME",
  oci_registry_password = "$CHART_OCI_REGISTRY_PASSWORD",
  version = "$APP_VERSION",
  params = {
    'EXAMPLE_PARAM': 'test',
    'REPOSITORY': "$REPOSITORY",
    'APP_VERSION': "$APP_VERSION",
    'CHART_OCI_REGISTRY': "$CHART_OCI_REGISTRY",
    'EXTERNAL_SUB_CHART_REPO': "$EXTERNAL_SUB_CHART_REPO",
    'INTERNAL_SUB_CHART_REPO': "$INTERNAL_SUB_CHART_REPO"

  },
  containers = [
    "//docker/example:image"
  ],
  sub_charts = [

  ]
)