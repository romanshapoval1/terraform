output "aws_amazon_linux_latest_id" {
  value = data.aws_ami.latest_amazon_linux.id
}

output "aws_amazon_linux_latest_name" {
  value = data.aws_ami.latest_amazon_linux.name
}

output "load_balancer_url" {
  value = aws_elb.Load_Balancer.dns_name
}
