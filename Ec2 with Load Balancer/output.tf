output "load_balancer_dns" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.Load_Balancer.dns_name
}

output "instance_public_ips" {
  description = "The public IPs of the EC2 instances"
  value       = [aws_instance.lb-instance-1.public_ip, aws_instance.lb-instance-2.public_ip]

}
