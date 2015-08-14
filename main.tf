provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region = "${var.aws_region}"
}


resource "aws_security_group" "default" {
    name = "terraform_example"
    description = "Used in the terraform"

    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    ingress {
        from_port = 80
        to_port = 80
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

}


resource "aws_elb" "web" {
  name = "terraform-example-elb"

  availability_zones = ["${element(aws_instance.web.*.availability_zone, 0)}"]

  listener {
    instance_port = 80
    instance_protocol = "http"
    lb_port = 80
    lb_protocol = "http"
  }

  instances = ["${element(aws_instance.web.*.id, 0)}"]
}


resource "aws_instance" "web" {
  count = 10
  connection {
    user = "ec2-user"
    key_file = "${var.key_path}"
  }

  instance_type = "m1.small"

  ami = "${lookup(var.aws_amis, var.aws_region)}"
  key_name = "${var.key_name}"

  security_groups = ["${aws_security_group.default.name}"]

  provisioner "remote-exec" {
    inline = [
        "sudo yum -y update",
        "sudo yum -y install nginx",
        "sudo systemctl start nginx"
    ]
  }
}
