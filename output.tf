output "web_app_url" {
  description = "The URL of the web app"
  value       = azurerm_linux_web_app.webapp.default_hostname
}