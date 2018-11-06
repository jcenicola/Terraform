resource "aws_key_pair" "mykey" {
  key_name   = "mykey"
  public_key = "${file("${var.path_to_public_key}")}"
}

resource "aws_instance" "jc-test"{
  ami = "${lookup(var.AMIS, var.AWS_REGION)}"
  instance_type = "t2.micro"
  key_name = "${aws_key_pair.mykey.key_name}"

provisioner "file" {
    source      = "script.sh"
    destination = "/tmp/script.sh"
   }

provisioner "remote-exec" {
    inline = [
      "chmod +x /tmp/script.sh",
      "sudo /tmp/script.sh",
    ]
  }
  
connection {
    user = "${var.instance_username}"
    private_key = "${file("${var.path_to_private_key}")}"
 }
}

output "ip" {
  value = "${aws_instance.jc-test.public_ip}"
 }
