source ../../auth-azure-cloudarch.sh
terraform init  -backend-config="../project.tfvars" 
# terraform init -backend-config="./tfstat_save.tfvar" 