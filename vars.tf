variable "aws_region" {}
variable "env" {
  description = "The name of the environment (e.g. prod, dev, uat, you-name-it)"
  type        = string
}

variable "mongodbatlas_project_id" {
  description = "The unique ID for the project to create the database user (e.g. 5dfa2eb71234567812345678)"
  type        = string
  default     = ""
}

variable "mongodbatlas_container_id" {
  description = "Unique identifier of the Atlas VPC container for the region (e.g. 5dfa34871111222233334444)"
  type        = string
  default     = ""
}

variable "account_id" {
  description = "XXX"
  type        = string
}

variable "vpc_id" {}
variable "vpc_cidr_block" {}

variable "vpc_public_subnets" {
  type = list
  default = []
}

variable "vpc_private_subnets" {
  type = list
  default = []
}

variable "vpc_public_route_tables" {
  type    = list
  default = []
}

variable "vpc_private_route_tables" {
  type = list
  default = []
}

variable "mongodbatlas_cidr_block" {
  type    = string
  default = ""
}

variable "tags" {
  type    = map(string)
  default = {}
}
  
