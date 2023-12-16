terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.31.0"
    }
  }
}
provider "aws" {
  region     = var.region
  access_key = "ASIA2JZIYU535TSBSLIX"
  secret_key = "8cz5xg3wROoqtvlCx5yIJAkt6oil8GKPfg+kIUJJ"
  token = "FwoGZXIvYXdzECgaDD0It5nw1OrWlA4ZgiK6AdpEESdXbNjUfXkB3l2zxIYE9l3AmGUIfoUCD6o0U4DBwWWrSrWWFeUDpVmCALKMyz/6EBIL9I5ZIMvMmme9n2QAimhVzUTxBhLXsessdOLJCbuExSjviWl0NwNd4oOdWnobkx55yrwBrWpI6V8m6FCe1/fWygTOH09DWHSPtziyWvVYztpggu7SPTL3QwXmshA4XgMUTRkTxjTabxZEBgTsKKcUderngOD+3+zWFuTx8CFHmqCIO+eJDii+6varBjItUVOGA5Uzez8eqbgm0PEPxFjLX6VbjukCuBVz/5Bbg8aJzf/Kz2C4lv0SRdA9"
}

provider "kubernetes" {
  host                   = module.eks.cluster_endpoint
  cluster_ca_certificate = base64decode(module.eks.cluster_certificate_authority_data)
  exec {
    api_version = "client.authentication.k8s.io/v1beta1"
    command     = "aws"
    args = ["eks", "get-token", "--cluster-name", module.eks.cluster_name]
  }
}

data "aws_availability_zones" "available" {}
data "aws_caller_identity" "current" {}
