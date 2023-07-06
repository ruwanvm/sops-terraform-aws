locals {
  my_aws_user = "arn:aws:iam::096281385844:user/docker-push-user"
}

locals {
  users = {
    prod = {
      name = "prod_user"
      tags = {
        environment = "prod"
      }
      policy = file("./policies/user-policy.json")
    }
    test = {
      name = "test_user"
      tags = {
        environment = "test"
      }
      policy = file("./policies/user-policy.json")
    }
  }
}

locals {
  keys = {
    prod = {
      description             = "Key for prod env using SOPS"
      deletion_window_in_days = 10
      policy                  = templatefile("./policies/key-policy.tpl", { key_users = [aws_iam_user.user["prod"].arn] })
      enable_key_rotation     = true
      tags = {
        use         = "example"
        environment = "prod"
        Name        = "prod-sops-key"
      }
    }
    test = {
      description             = "Key for test env using SOPS"
      deletion_window_in_days = 7
      policy                  = templatefile("./policies/key-policy.tpl", { key_users = [aws_iam_user.user["test"].arn] })
      enable_key_rotation     = true
      tags = {
        use         = "example"
        environment = "test"
        Name        = "test-sops-key"
      }
    }
  }
}


