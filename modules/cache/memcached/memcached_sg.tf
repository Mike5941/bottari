resource "aws_security_group" "memcached_sg" {
  name        = "memcached-sg"
  description = "Memcached Security Group"
  vpc_id      = data.terraform_remote_state.vpc.outputs.vpc_id

  ingress {
    from_port   = local.memcached_port
    to_port     = local.memcached_port
    protocol    = "tcp"
    cidr_blocks = local.my_ip
  }

  ingress {
    from_port   = local.memcached_port
    to_port     = local.memcached_port
    protocol    = "tcp"
    cidr_blocks = local.local_ip
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = local.all_protocols
    cidr_blocks = local.all_ip
  }

  tags = {
    Name = "Memcached SG"
  }
}