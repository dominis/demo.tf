variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "key_name" {}
variable "key_path" {}

variable "aws_region" {
    description = "AWS region to launch servers."
    default = "eu-west-1"
}

#Ccentos7 pv
variable "aws_amis" {
    default = {
        eu-west-1 = "ami-f2a4e085"
    }
}
