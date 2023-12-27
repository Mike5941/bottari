resource "aws_ec2_client_vpn_endpoint" "vpn" {
  depends_on = [aws_vpc.web_vpc]
  server_certificate_arn = var.server_arn

  client_cidr_block = "10.10.0.0/16"
  split_tunnel     = true

  authentication_options {
    type                       = "certificate-authentication"
    root_certificate_chain_arn = var.client_arn
  }

  connection_log_options {
    enabled = false
  }

}

resource "aws_ec2_client_vpn_network_association" "vpn" {
  depends_on = [aws_subnet.public_subnets]
  count = length(local.public_sn_id_list)
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  subnet_id              = local.public_sn_id_list[count.index]
}

resource "aws_ec2_client_vpn_authorization_rule" "vpn" {
  client_vpn_endpoint_id = aws_ec2_client_vpn_endpoint.vpn.id
  target_network_cidr    = local.all_ips
  authorize_all_groups   = true
}

#resource "null_resource" "example" {
#  provisioner "local-exec" {
#    command = "sed -i '4s/.*/remote ${aws_ec2_client_vpn_endpoint.vpn.id} 443' ${path.cwd}/client.ovpn"
#  }
#}