variable "instance_name" {
  description = "Name tag for the ec2 instance"
  type        = string
  default     = "nginx instance"
}

variable "instance_type" {
  description = "Type of the instance to use e.g. t2.micro"
  type        = string
  default     = "t2.micro"
}

variable "instance_count" {
  description = "The number of instances to be deployed"
  type        = number
  default     = 3
}

variable "ssh_key_private" {
  description = "Path to the private key used to access instances via ssh"
  type        = string
  default     = "~/.aws/us-east-2_vlad.pem"
}
