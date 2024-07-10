terraform {
  #required_version = ">=1.3.7"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~>3.43.0"
    }
  }
  backend "azurerm" {
    resource_group_name = "terraform-functionapp-rg"
    storage_account_name = "terraformstoragemodule"
    container_name = "terraformfolderrahul"
    key="tfmodulefunctionapp.tfstate"
    access_key = "VELDG5v42Sm589Y/PnIPhYDKBpXGzEhf+I78YJlFexIL4wq0wH8v15fVWb0iu+3JUuj08zFOZQx3+AStsEQo1Q=="
  }
}
provider "azurerm" {
  features {
  }
  skip_provider_registration = true
  subscription_id = "b437f37b-b750-489e-bc55-43044286f6e1"
}
/*locals {
  function_apps = {
    "azpoe-usedcapacity-nfs" = {
        appservicename = "azpoe-usedcapacity-appservice"
    }
    "azpoe-blobcapacity-nfs" = {
        appservicename = "azpoe-blobcapacity-appservice"
    }
  }
}*/
module "createfunctionapp" {
  source = "./modules/functionapps"
  for_each = var.function_apps
  functionappname = each.key
  appservicename = each.value.appservicename
}