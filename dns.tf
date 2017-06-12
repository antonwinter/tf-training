provider "dnsimple" {
  token   = "abcd1234"
  account = "nope"
}

resource "dnsimple_record" "example" {
  domain = "terraform.rocks"
  type   = "A"
  name   = "pancakes"
  #value  = "${aws_instance.web.0.public_ip}"

  # Alternatively
  value = "${element(aws_instance.web.*.public_ip, count.index)}"
}
