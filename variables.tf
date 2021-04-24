variable "instance_name" {
  description = "Name tage for the ec2 instance"
  type        = string
  default     = "nginx instance"
}

variable "ssh_key_private" {
  default = "~/.aws/us-east-2_vlad.pem"
}
