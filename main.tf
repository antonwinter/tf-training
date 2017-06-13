#
# DO NOT DELETE THESE LINES!
#
# Your AMI ID is:
#
#     ami-0b542c1d
#
# Your subnet ID is:
#
#     subnet-a98b11e1
#
# Your security group ID is:
#
#     sg-7621ce07
#
# Your Identity is:
#
#     jb-test-run-bat
#

provider "aws" {
  access_key = "${var.aws_access_key}"
  secret_key = "${var.aws_secret_key}"
  region     = "${var.aws_region}"
}

resource "aws_instance" "web" {
  ami                    = "ami-0b542c1d"
  instance_type          = "t2.micro"
  subnet_id              = "subnet-a98b11e1"
  vpc_security_group_ids = ["sg-7621ce07"]

  count = "${var.webserver_count}"

  tags {
    "Identity"           = "jb-test-run-bat"
    "Waffles"            = "awesome"
    "Bacon"              = "OHYEAH"
    "DoYouReadTheseTags" = "fantastic"
    "Name"               = "web ${count.index+1}/${var.webserver_count}"
  }
}

variable "aws_access_key" {}
variable "aws_secret_key" {}
variable "aws_region" {
  default = "us-east-1"
}

variable "webserver_count" {
  default = "4"
}

output "public_ip" {
  value = ["${aws_instance.web.*.public_ip}"]
}

output "public_dns" {
  value = ["${aws_instance.web.*.public_dns}"]
}

terraform {
  backend "atlas" {
    name = "antonwinter/training"
  }
}
