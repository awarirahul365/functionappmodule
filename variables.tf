variable "function_apps" {
  type = map(object({
    appservicename = string
  }))
}