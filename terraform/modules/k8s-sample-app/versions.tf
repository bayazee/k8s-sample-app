terraform {
  required_version = ">= 1.11.4"
  required_providers {

    kubernetes = {
      source  = "hashicorp/kubernetes"
      version = ">= 2.37.1"
    }
  }

}
