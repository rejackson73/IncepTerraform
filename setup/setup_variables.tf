# Auth0 Connection Variables
variable "auth0_domain" {
    type = string
    description = "Auth0 Domain for user creation"
}

variable "auth0_client_id" {
    type = string
    description = "Auth0 Client ID"
}

variable "auth0_client_secret" {
    type = string
    description = "Auth0 Client Secret"
}
