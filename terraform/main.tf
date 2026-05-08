provider "aws" {
  region = "us-east-1"
}

terraform {
  backend "s3" {
    bucket = "tu-nombre-terraform-state" # ¡CAMBIA ESTO AL NOMBRE DE TU BUCKET!
    key    = "demo/nextcloud.tfstate"
    region = "us-east-1"
  }
}
