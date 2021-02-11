provider "null" {
  version = "~> 2.1"
}

resource "null_resource" "version" {
    provisioner "local-exec" {
        command = "terraform version"
    }
}

module "label" {
  source     = "//third_party/terraform/module:cloudposse_null_label_0_12"
  namespace  = "eg"
  stage      = "prod"
  name       = "bastion"
  attributes = ["public"]
  delimiter  = "-"

  tags = {
    "BusinessUnit" = "XYZ",
    "Snapshot"     = "true"
  }
}

module "my_label" {
  source = "//terraform/examples/0.13/my_module:my_module"
}
