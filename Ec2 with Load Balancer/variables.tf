variable "region" {
  description = "This is the region where you will deply"
  type = string
  default = "value from tfvars"
}
variable "aws_access_key" {
  description = "This is AWS ACCESS KEY"
  type        = string
  sensitive   = true
}

variable "aws_secret_key" {
  description = "This is AWS SECRET KEY"
  type        = string
  sensitive   = true
}

variable "lb_vpc_cidr" {
  description = "The CIDR block for the load balancer VPC."
  type        = string
  default     = "value from tfvars"
}

variable "lb_subnet1" {
  description = "The CIDR block for the load balancer subnet 1."
  type        = string
  default     = "value from tfvars"
}
variable "lb_subnet2" {
  description = "The CIDR block for the load balancer subnet 2."
  type        = string
  default     = "value from tfvars"
}

variable "lb_ami" {
  description = "The AMI ID for the EC2 instance."
  type        = string
  default     = "value from tfvars" # Ubuntu Linux 2 AMI 
}

variable "lb_instance_type" {
  description = "The instance type for the load balancer."
  type        = string
  default     = "value from tfvars"

}
variable "lb_target_group_port" {
  description = "The port for the load balancer target group."
  type        = number
  default     = 80
}
