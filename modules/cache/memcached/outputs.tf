output "endpoint" {
  value = aws_elasticache_cluster.memcached[*].cluster_id
}