source ../../auth-azure-cloudarch.sh
# terraform plan  -var-file="../project.tfvars" -var-file="../default-tags.tfvars"  -out ./tfplan.out
terraform plan  -var-file="../project.tfvars" -var-file="../default-tags.tfvars" -out ./ftplan.out
