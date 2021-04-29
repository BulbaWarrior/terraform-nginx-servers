variable "vpc_cidr" {
  description = "cidr of the vpc and vpc subnet"
  type        = string
  default     = "10.0.0.0/24"
}

variable "tags" {
  description = "Tags to be asscociated with every network component"
  type        = map(any)
  default = {
    created_by = "vlad"
  }
}
