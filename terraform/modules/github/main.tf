terraform {
  required_providers {
    github = {
      source  = "integrations/github"
      version = "4.23.0"
    }
  }
}

resource "github_actions_secret" "public_key" {
  repository      = var.github_repository
  secret_name     = var.github_private_key_title
  plaintext_value = var.github_private_key_value
}

resource "github_actions_secret" "hosts" {
  repository      = var.github_repository
  secret_name     = var.github_hosts_key
  plaintext_value = join("\n", var.github_hosts_value)
}

resource "github_actions_secret" "hosts_user" {
  repository      = var.github_repository
  secret_name     = var.github_hosts_user_key
  plaintext_value = var.github_hosts_user_value
}