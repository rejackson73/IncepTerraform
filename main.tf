terraform {
  required_providers {
    tfe = {
      source = "hashicorp/tfe"
      version = "0.22.0"
    }
    github = {
      source = "hashicorp/github"
      version = "3.0.0"
    }
  }
}

# Configure the Terraform Enterprise Provider
provider "tfe" {
  hostname = var.hostname
  token = var.token
  version  = "~> 0.22.0"
}

# Configure the GitHub Provider
provider "github" {
  token = var.github_token
}


# Configure the Terraform Organization and Workspace(s)
resource "tfe_organization" "organization" {
  name  = var.new_organization
  email = var.new_org_email
}

resource "tfe_workspace" "workspace" {
  name         = var.new_workspace
  organization = tfe_organization.organization.name
  vcs_repo {
    identifier = github_repository.repo-man.full_name
    oauth_token_id = tfe_oauth_client.oauth-baby.oauth_token_id
  }
}

# Configure the Github Repository.  'auto_init' is a critical parameter!
resource "github_repository" "repo-man" {
  name        = "${var.new_workspace}-repo"
  description = "Github Repository for Workspace"
  auto_init = "true"
  visibility = "private"
}

# Setting up Oauth between repo and workspace
resource "tfe_oauth_client" "oauth-baby" {
  organization     = tfe_organization.organization.name
  api_url          = "https://api.github.com"
  http_url         = "https://github.com"
  oauth_token      = var.github_token
  service_provider = "github"
}

# Create user teams within Terraform.  These need to map to the Roles within the Auth0 Authorization Extension
resource "tfe_team" "teams" {
  for_each = toset(var.teams)

  name         = each.key
  organization = tfe_organization.organization.name
}

# Post Approved Modules to Private Module Registry
resource "tfe_registry_module" "filthy-animal" {
  for_each = var.modules

  vcs_repo {
    display_identifier = each.value
    identifier         = each.value
    oauth_token_id     = tfe_oauth_client.oauth-baby.oauth_token_id
  }
}

# Post Necessary policies to Private Module Registry
resource "tfe_policy_set" "alongcamepollysee" {
  for_each = var.policy_sets

  name          = each.key
  description   = "Managing Polly's access to crackers"
  organization  = tfe_organization.organization.name
  workspace_ids = [tfe_workspace.workspace.id] # Apply to all workspaces, or selected workspaces

  vcs_repo {
    identifier         = each.value
    oauth_token_id     = tfe_oauth_client.oauth-baby.oauth_token_id
  }
}