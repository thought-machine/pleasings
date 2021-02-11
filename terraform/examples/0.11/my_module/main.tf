module "label" {
  source     = "//third_party/terraform/module:cloudposse_null_label_0_11"
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

resource "null_resource" "version" {
    provisioner "local-exec" {
        command = "terraform version"
    }
}
