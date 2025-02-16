module "secrets-manager" {

  source = "lgallard/secrets-manager/aws"

  secrets = {
    secret-1 = {
      description             = "My secret 1"
      recovery_window_in_days = 7
      secret_string           = "TOP SECRET STRING No. 1, DO NOT DISCLOSE TO ANYONE!"
    }
  }

  tags = {
    Owner       = "DevOps team"
    Environment = "dev"
    Terraform   = true

  }
}