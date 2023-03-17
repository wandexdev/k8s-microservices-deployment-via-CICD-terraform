#----------------------------BACKEND-------------------------
variable "S3_bucket_name" {
    description = "remote backend storage for safe guarding the terraform state and backup files"
}

variable "bucket_key" {
    description = "It's the file path inside the bucket"
}

variable "region" {
    description = "The region of cluster deployment"
}

#--------------------------------VPC-------------------------------#

variable "vpc_cidr_block" {
    description = "ip range for vpc"
}

variable "private_subnet_cidr_blocks" {
    description = "ip range for private subnet"
}

variable "public_subnet_cidr_blocks" {
    description = "ip range for public subnets"
}

#variable "environment_prefix" {
#  description = "environment name for the archeiture"
#}

#----------------------CICD-SERVER-----------------------#
variable "key_pair" {
    description = "name of key pair"
}

variable "local_public_key_location" {
    description = "my personal public key"
}

variable "local_private_key_location" {
    description = "my personal private key"
}

variable "instance_type" {
    description = "specific type of instance"
}