variable "instance_ami" {
  type = string
}

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

variable "instance_key_name" {
  description = "Name of the ssh key used to log in to the instances"
  type        = string
  default     = "us-east-2_vlad"
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

variable "subnet_id" {
  description = "id of the vpc subnet to which the instances will be deployed"
  type        = string
}

variable "security_groups" {
  description = "IDs of security groups associated with instances"
  type        = list(string)
}

variable "playbook_path" {
  description = "Path to ansible playbook to be executed with the created host as inventory"
  type        = string
  default     = "ansible/playbool.yml"
}
