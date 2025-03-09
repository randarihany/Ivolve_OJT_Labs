output "server1_instance_id" {
  value = module.server1.instance_id
}

output "server2_instance_id" {
  value = module.server2.instance_id
}

output "server1_private_key" {
  value     = module.server1.private_key
  sensitive = true
}

output "server2_private_key" {
  value     = module.server2.private_key
  sensitive = true
}
