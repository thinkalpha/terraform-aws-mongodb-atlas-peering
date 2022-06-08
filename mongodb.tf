resource "mongodbatlas_network_peering" "cluster" {
  accepter_region_name   = var.aws_region
  project_id             = var.mongodbatlas_project_id
  container_id           = var.mongodbatlas_container_id
  provider_name          = "AWS"
  route_table_cidr_block = var.vpc_cidr_block
  vpc_id                 = var.vpc_id
  aws_account_id         = var.account_id
}

# the following assumes an AWS provider is configured  
resource "aws_vpc_peering_connection_accepter" "mongodbatlas" {
  vpc_peering_connection_id = mongodbatlas_network_peering.cluster.connection_id
  auto_accept               = true

  tags                      = var.tags
}

resource "mongodbatlas_project_ip_access_list" "pcx" {
  project_id = var.mongodbatlas_project_id
  cidr_block = var.vpc_cidr_block
  comment    = "${var.env} vpc peering - terraform"
}

# We do not run workloads that required access to mongodb in public subnets
resource "aws_route" "mongodbatlas_public" {
  for_each                  = toset(var.vpc_public_route_tables)
  route_table_id            = each.value
  destination_cidr_block    = var.mongodbatlas_cidr_block
  vpc_peering_connection_id = mongodbatlas_network_peering.cluster.connection_id
}

resource "aws_route" "mongodbatlas_private" {
  for_each                  = toset(var.vpc_private_route_tables)
  route_table_id            = each.value
  destination_cidr_block    = var.mongodbatlas_cidr_block
  vpc_peering_connection_id = mongodbatlas_network_peering.cluster.connection_id
}
