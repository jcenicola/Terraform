#Variables

variable "AWS_ACCESS_KEY" {}
variable "AWS_SECRET_KEY" {}
variable "AWS_REGION" {
 	default = "us-west-1"
}

variable "AMIS" {
  type = "map"
  default = {
    us-west-1 = "ami-6edc380d"
 }
}

variable "path_to_private_key" {
  default = "mykey"
}

variable "path_to_public_key" {
  default = "mykey.pub"
}

variable "instance_username" {
  default = "ec2-user"
}
