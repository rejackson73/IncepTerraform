# Terraform System Variables

variable "hostname" {
  type        = string
  description = "Hostname of the TFE/C Server"
}

variable "token" {
  type        = string
  description = "Privileged User Token for TFE/C Server"
}

# Consumer Variables

variable "teams" {
    type = list
    description = "List of teams that need to map to the Roles within the Auth0 Authorization Extension"
}

# Organization Variables
variable "new_organization" {
    type = string
    description = "Name for new organization to be created"
}

variable "new_org_email" {
    type = string
    description = "Email address for Organization admin"
}

# Workspace Variables
variable "new_workspace" {
    type = string
    description = "Workspace to be added to Organization"
}

# Github Variables
variable "github_token" {
    type = string
    description = "Github token with authorization levels to create repository"
}

variable "github_organization" {
    type = string
    description = "Github organization in which repository lies"
}

# Repository maps for modules and policies
variable "modules" {
    type = map
    description = "map of display identifier, and identifier, for the VCS repo for modules"

}

variable "policy_sets" {
    type = map
    description = "map of name, description, and identifier for VCS repo for policy sets"
}