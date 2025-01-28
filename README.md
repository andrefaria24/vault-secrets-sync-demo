# HCP Vault Secrets Sync demo

## Demo Prerequisites

* **HashiCorp Cloud Platform Account**
* **AWS Account**
* **Microsoft Azure Account**
* **App registration with client secret already created within Azure**

## Demo Setup

1. Clone this repository
2. Set terraform.tfvars values are required with AWS & Azure keys
3. Initialize Terraform configuration
    ```
    terraform init
    ```
4. Validate the Terraform environment and resolve any errors
    ```
    terraform validate
    ```
5. Review the terraform plan and apply changes
    ```
    terraform plan
    terraform apply
    ```
6. Execute the setEnvVars.ps1 script to set the required environmnet variables
    ```
    .\scripts\setEnvVars.ps1
    ```

7. Login to HVD Vault and confirm correct active node dddress
    ```
    vault login $Env:VAULT_TOKEN
    vault status
    ```

## Demo Execution

1. Activate the secrets sync feature
    ```
    vault write -f sys/activation-flags/secrets-sync/activate
    ```
2. Configure AWS & Azure destinations within Secrets Sync
    ```
    vault write sys/sync/destinations/aws-sm/aws-sm-1 `
      access_key_id=$env:AWS_ACCESS_KEY_ID `
      secret_access_key=$env:AWS_SECRET_ACCESS_KEY `
      secret_name_template="{{ .MountAccessor }}_{{ .SecretBaseName }}"
    ```
    ```
    vault write sys/sync/destinations/azure-kv/azr-kv-1 key_vault_uri=$env:AZR_KEYVAULT_URI `
      client_id=$env:AZR_CLIENT_ID `
      client_secret=$env:AZR_CLIENT_SECRET `
      secret_name_template="{{ .MountAccessor }}_{{ .SecretBaseName }}" `
      tenant_id=$env:AZR_TENANT_ID
    ```
3. Create an association between the destination and a secret to synchronize
    ```
    vault write sys/sync/destinations/aws-sm/aws-sm-1/associations/set mount='kvv2' secret_name='database/dev'
    ```
    ```
    vault write sys/sync/destinations/azure-kv/azr-kv-1/associations/set mount='kvv2' secret_name='database/dev'
    ```
4. Log into AWS & Azure and take a navigate to the AWS Secrets Manager / Azure Key Vault to view secrets

5. Update the secret
    ```
    vault kv put kvv2/database/dev api_key="foo" key_id="updated"
    ```

6. Re open AWS / Azure and reload secret to view updates value

7. Use patch command to add additional fields
    ```
    vault kv patch -mount=kvv2 database/dev new_value="bar"
    ```

8. Showcase association removal
    ```
    vault write sys/sync/destinations/aws-sm/aws-sm-1/associations/remove mount="kvv2" secret_name="database/dev"
    ```
    ```
    vault write sys/sync/destinations/azure-kv/azr-kv-1/associations/remove mount="kvv2" secret_name="database/dev"
    ```

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.9.3 |
| <a name="requirement_hcp"></a> [hcp](#requirement\_hcp) | = 0.100.0 |
| <a name="requirement_vault"></a> [vault](#requirement\_vault) | = 4.5.0 |
| <a name="requirement_aws"></a> [aws](#requirement\_aws) | = 5.80.0 |
| <a name="requirement_azurerm"></a> [azurerm](#requirement\_azurerm) | = 3.0.0 |