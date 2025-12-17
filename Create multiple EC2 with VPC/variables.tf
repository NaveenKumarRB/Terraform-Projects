variable "aws_access_key" {
  description = "This is AWS Access Key"
  type        = string
  sensitive   = true
  default     = "value from tfvars file"
}

variable "aws_secret_key" {
  description = "This is AWS Secret Key"
  type        = string
  sensitive   = true
  default     = "value from tfvars file"
}

variable "region" {
  description = "This is Where you will create instance"
  type        = string
  default     = "value from tfvars file"
}

variable "key_pair" {
  description = "This is Key Pair Name"
  type        = string
  default     = "naveen"
}

variable "my_vpc" {
  description = "This is VPC CIDR Block"
  type        = string
  default     = "value from tfvars file"
}

variable "my_subnet" {
  description = "This is Subet CIDR Range"
  type        = string
  default     = "value from tfvars file"
}

variable "ami" {
  description = "This is AMI ID"
  type        = string
  default     = "value from tfvars file"

}
variable "instance_type" {
  description = "This is Instance Type"
  type        = string
  default     = "value from tfvars file"

}