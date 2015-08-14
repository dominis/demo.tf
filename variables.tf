variable "key_name" {
    description = "Name of the SSH keypair to use in AWS."
    default = "GMGWEB"
}

variable "key_path" {
    description = "Path to the private portion of the SSH key specified."
    default = "~/.ssh/GMGWEB.pem"
}

variable "aws_region" {
    description = "AWS region to launch servers."
    default = "eu-west-1"
}

#CentOS 7.1 x86_64 with cloud-init (HVM)
variable "aws_amis" {
    default = {
        eu-west-1 = "ami-67a3d810"
    }
}
