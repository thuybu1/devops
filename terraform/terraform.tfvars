# states_bucket_name   = "lab1-states"
# states_bucket_region = "us-east-1"
# PROJECT
project_prefix = "DevOps"

# PROVIDER
access_key      = "AKIAXHVGPJJMRBHE6C2K"
secret_key      = "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"
provider_region = "us-east-1"

# VPC
vpc_cidr        = "10.0.0.0/16"
azs             = ["us-east-1a", "us-east-1b"]
public_subnets  = ["10.0.1.0/24", "10.0.3.0/24"]
private_subnets = ["10.0.2.0/24", "10.0.4.0/24"]
common_tags = {
  "Terraform" = "TRUE"
  "Project"   = "SDE DevOps"
}

# INSTANCES
ami_name      = "web_server_ami"
origin_name   = "Original Web Server"
ami_type      = "ami-03c7d01cf4dedc891"
instance_type = "t2.micro"
user_data     = <<-EOF
              #!/bin/bash
              sudo yum update -y
              sudo yum install git -y
              sudo amazon-linux-extras install docker
              sudo curl -L "https://github.com/docker/compose/releases/latest/download/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
              sudo chmod +x /usr/local/bin/docker-compose
              sudo usermod -aG docker ec2-user
              sudo git clone https://github.com/thuybu1/spamdetectionweb.git
              sudo docker-compose build
              sudo docker-compose up -d
              EOF


