tf_login:
	@ echo "Logging into Terraform Cloud..."
	@ terraform login

# tf_dev:
# 	@ echo "Running Terraform for dev environment..."
# 	@ cd env/dev && terraform fmt -recursive && terraform init && terraform plan

# tf_prod:
# 	@ echo "Running Terraform for prod environment..."
# 	@ cd env/prod && terraform fmt -recursive && terraform init && terraform plan

# dev
tf_dev_init:
	@ echo "Initializing Terraform for dev environment..."
	@ cd env/dev && terraform fmt -recursive && terraform init

tf_dev_validate:
	@ echo "Validating Terraform configuration for dev environment..."
	@ cd env/dev && terraform fmt -recursive && terraform validate

tf_dev_plan:
	@ echo "Planning Terraform changes for dev environment..."
	@ cd env/dev && terraform fmt -recursive && terraform plan

tf_dev_apply:
	@ echo "Applying Terraform changes for dev environment..."
	@ cd env/dev && terraform fmt -recursive && terraform apply

tf_dev_output:
	@ echo "Displaying Terraform outputs for dev environment..."
	@ cd env/dev && terraform fmt -recursive && terraform output
# 	@ cd env/dev && terraform fmt -recursive && terraform output -json > outputs.json
# 	@ cd env/dev && terraform fmt -recursive && cat outputs.json | jq -r '.api_gateway_url.value' > api_gateway_url.txt
# 	@ cd env/dev && terraform output -raw api_gateway_url

tf_dev_destroy:
	@ echo "Destroying Terraform-managed infrastructure for dev environment..."
	@ cd env/dev && terraform fmt -recursive && terraform destroy

# stage
tf_stage_init:
	@ echo "Initializing Terraform for stage environment..."
	@ cd env/stage && terraform fmt -recursive && terraform init

tf_stage_plan:
	@ echo "Planning Terraform changes for stage environment..."
	@ cd env/stage && terraform fmt -recursive && terraform plan

tf_stage_apply:
	@ echo "Applying Terraform changes for stage environment..."
	@ cd env/stage && terraform fmt -recursive && terraform apply

# prod
tf_prod_init:
	@ echo "Initializing Terraform for prod environment..."
	@ cd env/prod && terraform fmt -recursive && terraform init

tf_prod_plan:
	@ echo "Planning Terraform changes for prod environment..."
	@ cd env/prod && terraform fmt -recursive && terraform plan

tf_prod_apply:
	@ echo "Applying Terraform changes for prod environment..."
	@ cd env/prod && terraform fmt -recursive && terraform apply