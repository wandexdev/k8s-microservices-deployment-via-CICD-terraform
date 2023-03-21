output "ec2_public_ip" {
  value = aws_instance.wandek8s-server.public_ip
}