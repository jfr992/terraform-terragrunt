variable "vpc_cidr_block" {
  type        = string
  description = "cidr for vpc"
}

variable "public_cidr" {
  type        = string
  description = "public_cidr"
}

variable "private_1_cidr" {
  type        = string
  description = "private_1_cidr"
}

variable "private_2_cidr" {
  type        = string
  description = "private_2_cidr"
}

variable "az-id-1" {
  type        = string
  description = "availability zone 1"
}

variable "az-id-2" {
  type        = string
  description = "availability zone 2"
}

variable "instance_type" {
  type        = string
  description = "instance_type"
}

variable "asg_desired_capacity" {
  type        = string
  description = "asg_desired_capacity"
}

variable "asg_min_size" {
  type        = string
  description = "asg_min_size"
}

variable "asg_max_size" {
  type        = string
  description = "asg_max_size"
}

variable "alb_allowed_ingress_cidrs" {
  type        = list(string)
  description = "alb_allowed_ingress_cidrs"
}

