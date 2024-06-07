resource "github_repository" "this" {
  name       = var.repository_name
  visibility = "private"
  auto_init  = true
}

resource "github_repository_file" "gitignore" {
  repository          = github_repository.this.name
  file                = ".gitignore"
  content             = ".idea"
  overwrite_on_create = true
}

resource "github_repository_file" "service" {
  for_each = var.services

  repository = github_repository.this.name
  file       = "services/${each.key}.yaml"
  content = templatefile("./config/services/${each.key}.tfpl", {
    version     = each.value.version
    value_files = jsonencode(each.value.value_files)
  })
  overwrite_on_create = true
}

resource "github_repository_file" "application" {
  for_each = var.applications

  repository = github_repository.this.name
  file       = "applications/${each.key}.yaml"
  content = templatefile("./config/applications/${each.key}.tfpl", {
    version     = each.value.version
    value_files = jsonencode(each.value.value_files)
  })
  overwrite_on_create = true
}
