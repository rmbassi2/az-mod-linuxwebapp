# Create an App Service Plan for the Web App
resource "azurerm_service_plan" "asp" {
  name                = "webapp-service-plan"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name = "B1"
  os_type = "Linux"
}


# Create the Web App
resource "azurerm_linux_web_app" "webapp" {
  name                = "webapp${random_string.webapp_suffix.result}"
  location            = var.location
  resource_group_name = var.resource_group_name
  service_plan_id = azurerm_service_plan.asp.id

  site_config {
    application_stack {
      python_version = "3.8"
    }
  }

  app_settings = {
    "FUNCTION_APP_URL" = var.function_app_url
  }
}

# Generate a random string for a unique web app name
resource "random_string" "webapp_suffix" {
  length  = 6
  special = false
  upper   = false
}

# Output the Web App URL
output "web_app_url" {
  value = azurerm_linux_web_app.webapp.default_hostname
}
