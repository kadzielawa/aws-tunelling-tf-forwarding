variable "AWS_REGION" {
     default = "eu-central-1"
}
variable "AMIS" {
    type = map
    default = {
        eu-central-1 = "ami-074a2642e2a3737d2"
    }
}
variable "KEY_NAME" {
    description = "Key name for SSHing into EC2"
    default = "stage_key_test"
}