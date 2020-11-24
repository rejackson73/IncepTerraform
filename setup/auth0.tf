terraform {
  required_providers {
    auth0 = {
      source = "alexkappa/auth0"
      version = "0.15.2"
    }
  }
}

provider "auth0" {
  domain = var.auth0_domain
  client_id = var.auth0_client_id
  client_secret = var.auth0_client_secret
}

# Test Users for Auth0
resource "auth0_user" "dev_user" {
  connection_name = "Username-Password-Authentication"
  username = "dev_user"
  email = "dev@mydomain.com"
  email_verified = true
  password = "passpass$12$12"
  roles = [ auth0_role.dev.id ]
}

resource "auth0_user" "test_user" {
  connection_name = "Username-Password-Authentication"
  username = "test_user"
  email = "test@mydomain.com"
  email_verified = true
  password = "passpass$12$12"
  roles = [ auth0_role.test.id ]
}

resource "auth0_user" "prod_user" {
  connection_name = "Username-Password-Authentication"
  username = "prod_user"
  email = "prod@mydomain.com"
  email_verified = true
  password = "passpass$12$12"
  roles = [ auth0_role.prod.id ]
}

# Test Roles for the Users
resource "auth0_role" "admin" {
  name = "admin"
  description = "Role for Administrators"
}
resource "auth0_role" "dev" {
  name = "dev"
  description = "Role for Developers"
}
resource "auth0_role" "test" {
  name = "test"
  description = "Role for QA Users"
}
resource "auth0_role" "prod" {
  name = "prod"
  description = "Role for Production Users"
}