data "azurerm_resource_group" "rg" {
  name     = "terraform-functionapp-rg"
}

data "azurerm_storage_account" "storage" {
  name                     = "terraformstoragemodule"
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_app_service_plan" "appservice" {
  name                = "${var.appservicename}"
  location            = data.azurerm_resource_group.rg.location
  resource_group_name = data.azurerm_resource_group.rg.name
  kind                = "Linux"
  reserved            = true

  sku {
    tier = "Dynamic"
    size = "Y1"
  }
}

resource "azurerm_function_app" "functionapp" {
  name                       = "${var.functionappname}"
  location                   = data.azurerm_resource_group.rg.location
  resource_group_name        = data.azurerm_resource_group.rg.name
  app_service_plan_id        = azurerm_app_service_plan.appservice.id
  storage_account_name       = data.azurerm_storage_account.storage.name
  storage_account_access_key = data.azurerm_storage_account.storage.primary_access_key
  os_type                    = "linux"
  version                    = "~4"
  
  site_config {
    linux_fx_version = "python|3.11"
  }
  app_settings = {
    FUNCTIONS_WORKER_RUNTIME="python"
  }
}