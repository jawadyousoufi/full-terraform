# oct-2021-terraform
## This code is used to build VPC
In order to build VPC: 
1. Update envs folder 
2. Execute 
```
terraform init 
terraform apply -var-file envs/ENVIRONMENT.tfvars -auto-approve
```