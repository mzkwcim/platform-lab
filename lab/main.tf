provider "azurerm" {
  features {}
}

terraform {
  backend "azurerm" {
    use_azuread_auth     = true
    use_cli              = true
    storage_account_name = "satflabmzkwcim01"
    container_name       = "tfstate"
    key                  = "platform-lab.tfstate"
  }
}

resource "azurerm_resource_group" "terraform_lab" {
  name     = "rg-terraform-lab"
  location = "polandcentral"
  lifecycle {
    ignore_changes = [tags]
  }
}

moved {
  from = azurerm_resource_group.lab
  to   = azurerm_resource_group.terraform_lab
}