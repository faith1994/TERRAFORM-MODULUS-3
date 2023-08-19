# export the region
output "region" {
  value = var.region
}

# export the production name
output "production_name" {
  value = var.production
}

# export the testing
output "testing" {
  value = var.testing
}

 #export developing
output "developing" {
  value = var.developing
}

# export the vpc id
output "vpc_id" {
  value = aws_vpc.vpc_cidr.id
}

# export the internet gateway
output "internet_gateway" {
  value = web_igw
}

# export the public subnet1 id
output "web_public_subnet1" {
  value = aws_subnet.web_public_subnet1.id
}

# export the public subnet2 id
output "web_public_subnet2" {
  value = aws_subnet.web_public_subnet2.id
}

# export the private app subnet1 id
output "web_private_subnet1" {
  value = aws_subnet.aweb_private_subnet1.id
}

# export the private app subnet2 id
output "web_private_subnet2" {
  value = aws_subnet.aweb_private_subnet2.id
}

# export the first availability zone
output "availability_zone_1" {
  value = data.aws_availability_zones.available_zones.names[2]
}

# export the second availability zone
output "availability_zone_2" {
  value = data.aws_availability_zones.available_zones.names[0]
}

# export the second availability zone
output "availability_zone_3" {
  value = data.aws_availability_zones.available_zones.names[1]
}