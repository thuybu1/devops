# SECURITY GROUPS
# Original Web Server
module "web_instance_sg" {
  source = "terraform-aws-modules/security-group/aws"

  name = "web_sg"
  vpc_id = var.vpc_id

  description = "Security group with HTTP ports open publicly, egress ports are publicly open"
  # Ingress Rules & CIDR Block  
  ingress_rules = ["http-80-tcp", "https-443-tcp", "ssh-tcp"]
  ingress_cidr_blocks = ["0.0.0.0/0"]
  # Egress Rule - all-all open
  egress_rules = ["all-all"]

  tags = var.common_tags
}
