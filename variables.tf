variable "repository_name" {
  type = string
}

variable "services" {
  type = map(object({
    namespace   = string
    version     = string
    value_files = list(string)
  }))
}

variable "applications" {
  type = map(object({
    namespace   = string
    version     = string
    value_files = list(string)
  }))
}
