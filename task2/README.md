# TASK 1
Prepare terraform file that could provision aws lb forwarding traffic to target group of at least 2 ec2 instances scalable up to 5 via asg on cpu scalling policy.


Terraform state is configured to be stored in s3 [https://www.terraform.io/docs/providers/terraform/d/remote_state.html](https://www.terraform.io/docs/providers/terraform/d/remote_state.html).

The bucket, KMS key and DynamoDb table specified in **main.tf** were created manually.

profile, referenced in **main.tf** contains AWS secrets which has the following IAM permissions attached:

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Action": "s3:ListBucket",
        "Resource": "arn:aws:s3:::muume-terraform-states"
        },
        {
        "Effect": "Allow",
        "Action": ["s3:GetObject", "s3:PutObject"],
        "Resource": "arn:aws:s3:::muume-terraform-states/*"
        }
    ]
}
```

```json
{
    "Version": "2012-10-17",
    "Statement": [
        {
        "Effect": "Allow",
        "Action": [
            "dynamodb:GetItem",
            "dynamodb:PutItem",
            "dynamodb:DeleteItem"
        ],
        "Resource": "arn:aws:dynamodb:*:*:table/terraform-locks"
        }
    ]
}
```

## Terraform credentials
Since Terraform will manage the whole infrastructure, including IAM roles etc. It needs credentials with a PowerUser rolle attached.

To make this process secure, we will get use of aws-vault tool.

The way it works - you add PowerUser credentials into the secured vault, and before terraform operations you populate credentials into environment variables via aws-vault.

How to use aws-vault and Terraform:

Install the tool: brew cask install aws-vault
Add the PowerUser credentials into the vault (in this example muume-test environment credentials): 
```sh
aws-vault add xxxx-tfstate
```
Once you are ready to work with Terraform, populate the environment variables with aws-vault: 
```sh
aws-vault exec xxxx-tfstate
```
