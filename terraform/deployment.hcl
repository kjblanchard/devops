locals {
    account_id = "145035066069"
    tf_state_bucket = "supergoon-wedding-terraform-state"
    k8s_context = "minikube"
    aws_region = "us-east-1"
    config = {
        flask = {
            tag = "latest"
        }
    }
}