terraform {
  required_providers {
    civo = {
      source  = "civo/civo"
      version = ">= 1.0.49"
    }
    random = {
      source = "hashicorp/random"
      version = ">= 3.0.0"
    }
  }
  required_version = ">= 1.5.7"
}