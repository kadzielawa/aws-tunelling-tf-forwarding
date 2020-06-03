# TASK 1
Prepare terraform file that could provision aws lb forwarding traffic to target group of at least 2 ec2 instances scalable up to 5 via asg on cpu scalling policy.

## Terraform credentials
Since Terraform will manage the whole infrastructure, including IAM roles etc. It needs credentials with a PowerUser rolle attached.

To make this process secure, we will get use of aws-vault tool.

The way it works - you add PowerUser credentials into the secured vault, and before terraform operations you populate credentials into environment variables via aws-vault.

How to use aws-vault and Terraform:

Install the tool: brew cask install aws-vault
Add the PowerUser credentials into the vault (in this example muume-test environment credentials): aws-vault add muume-test-terraform
Once you are ready to work with Terraform, populate the environment variables with aws-vault: aws-vault exec muume-test-terraform

