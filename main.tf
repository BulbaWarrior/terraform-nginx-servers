resource "aws_s3_bucket" "terraform_state" {
  bucket = "vlados-chum-bucket"

  versioning {
    enabled = true
  }

  server_side_encryption_configuration {
    rule {
      apply_server_side_encryption_by_default {
        sse_algorithm = "AES256"
      }
    }
  }
}

module "aws_network" {
  source = "./modules/network"
}

module "instances" {
  source          = "./modules/instances"
  subnet_id       = module.aws_network.vpc_subnet.id
  security_groups = [module.aws_network.security_group.id]
  instance_ami    = "ami-01e7ca2ef94a0ae86"
}
