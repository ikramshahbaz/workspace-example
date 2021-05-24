provider "azurerm" {
  features {}
}

module "instance" {
  source             = "./instance"
  rgname             = terraform.workspace
  location           = "West Europe"
  main_network_name  = "${terraform.workspace}-network"
  main_address_space = ["10.0.0.0/16"]
  subnet_name        = "${terraform.workspace}-subnet"
  #  internal_subnet_address_space = ["10.0.1.0/24", "10.0.2.0/24"]
  internal_subnet_address_count = 3
  internal_subnet_address_space = [for i in range(1, 255, 2) : cidrsubnet("10.0.0.0/16", 8, i)]
  tags = {
    application = "EPIMS"
    environment = "${terraform.workspace}"
  }
}
