include "root" {
  path = find_in_parent_folders()
}

inputs = {
  vpc_cidr_block            = "192.168.0.0/16"
  public_cidr               = "192.168.0.0/24"
  private_1_cidr            = "192.168.1.0/24"
  private_2_cidr            = "192.168.2.0/24"
  az_id_1                   = "us-east-2a"
  az_id_2                   = "us-east-2b"
  instance_type             = "t2.micro"
  asg_desired_capacity      = "1"
  asg_min_size              = "1"
  asg_max_size              = "2"
  alb_allowed_ingress_cidrs = ["192.168.0.0/16"]
}