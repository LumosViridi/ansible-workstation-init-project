data "aws_vpc" "default" {
  default = true
}

data "aws_subnets" "default" {
  filter {
    name   = "vpc-id"
    values = [data.aws_vpc.default.id]
  }
  filter {
    name   = "availability-zone"
    values = ["us-east-1a"] # MacOS metal is not available in all AZ's, picking one
  }
}

data "aws_subnet" "default" {
  id = data.aws_subnets.default.ids[0]
}

data "aws_ami" "macos_ami" {
  most_recent = true
  owners      = ["628277914472"] # Amazon AMI Account ID

  filter {
    name   = "name"
    values = ["amzn-ec2-macos-14.5-*"]
  }
  filter {
    name   = "architecture"
    values = ["arm64_mac"] # M1 Apple Silicon
  }
}

resource "aws_security_group" "macos_sg" {
  vpc_id      = data.aws_vpc.default.id
  name_prefix = "macos_sg_"

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"] # For testing purposes only of course...
  }

  ingress {
    from_port   = -1
    to_port     = -1
    protocol    = "icmp"
    cidr_blocks = ["0.0.0.0/0"] # For testing purposes only of course...
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"] # For testing purposes only of course...
  }

  tags = {
    Name = "macos-ec2-sg"
  }
}

resource "aws_ec2_host" "macos" {
  instance_type     = "mac2.metal"
  availability_zone = data.aws_subnet.default.availability_zone
  host_recovery     = "off" # not supported for mac
  auto_placement    = "on"
}

resource "aws_instance" "macos" {
  ami           = data.aws_ami.macos_ami.id
  instance_type = "mac2.metal"
  tenancy       = "host"
  host_id       = aws_ec2_host.macos.id

  subnet_id              = data.aws_subnets.default.ids[0]
  key_name               = "you-key-pair"
  vpc_security_group_ids = [aws_security_group.macos_sg.id]

  root_block_device {
    volume_size           = 100
    volume_type           = "gp3"
    delete_on_termination = true
  }

  tags = {
    Name = "macos-ec2-instance"
  }
}

output "macos_public_ip" {
    value = aws_instance.macos.public_ip
}
output "macos_public_dns" {
    value = aws_instance.macos.public_dns
}
