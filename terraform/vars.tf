variable "common_tags" {
  description = "Default tags for resources"
  type        = map(any)

  default = {
    environment = "test"
  }
}

variable "image_id" {
  description = "Image ID"
  type        = string

  default = "/subscriptions/f5c1daeb-9408-42b4-bdb3-2e2751713637/resourceGroups/Azuredevops/providers/Microsoft.Compute/images/CustomUbuntuImage"
}

variable "number_of_vm" {
  description = "Number of virtual machines"
  type        = number

  default = 1
}