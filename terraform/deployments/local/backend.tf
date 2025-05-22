terraform {
    # This is not recommended for production use!
    # Sattefiles should be stored in a remote backend such as AWS S3
    # We should also use a locking mechanism to prevent concurrent writes
  backend "local" {
    path = "terraform.tfstate"    
  }
}