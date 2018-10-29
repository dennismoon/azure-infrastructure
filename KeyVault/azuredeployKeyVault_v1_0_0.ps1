# sign in
Write-Output "Logging in...";
# Connect-AzureRmAccount

# Select Subscription
$subscriptionName = 'SubName'
Select-AzureRmSubscription -SubscriptionName $subscriptionName

# Configure Variables
$deploymentMode = 'Incremental'
$resourceGroupName = 'RG-'
$templateBasePath = "C:\srcARM\Azure-Infrastructure\KeyVault\"
$templateFilePath = $templateBasePath + "azuredeployKeyVault_v1_0_0.json"
$parametersFilePath = $templateBasePath + "azuredeployKeyVault_v1_0_0.parameters.json"

# Test the deployment template
Test-AzureRmResourceGroupDeployment `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile $templateFilePath `
  -TemplateParameterFile $parametersFilePath;

# Start the deployment
Write-Output "Starting deployment...";
$Time = [System.Diagnostics.Stopwatch]::StartNew()

New-AzureRmResourceGroupDeployment `
  -Mode $deploymentMode `
  -ResourceGroupName $resourceGroupName `
  -TemplateFile $templateFilePath `
  -TemplateParameterFile $parametersFilePath;

$CurrentTime = $Time.Elapsed

Write-Output $([string]::Format("`rTime: {0:d2}:{1:d2}:{2:d2}", $CurrentTime.hours, $CurrentTime.minutes, $CurrentTime.seconds)) -nonewline

# Get-AzureRMLog -CorrelationId "129ed802-d7ec-4e91-ae34-809ecaaa3bf0"

# https://blogs.technet.microsoft.com/kv/2017/05/10/azure-key-vault-recovery-options/

# To see all the vaults in your subscription in deleted state, run this cmdlet:
# Get-AzureRmKeyVault -InRemovedState

# Set the target key vault name
# $keyVaultName = "KV"
# $location = "northcentralus"

# Remove-AzureRmKeyVault -VaultName $keyVaultName

# To recover a vault, you need to specify the vault name, resource group and location:
# Undo-AzureRmKeyVaultRemoval -VaultName $keyVaultName -ResourceGroupName $resourceGroupName -Location $location
# When a vault is recovered, all the keys/secrets in the vault will also become accessible again.

# To purge (that is permanently delete) a vault run 'Remove-AzureRmKeyVault' with '-InRemovedState'
# and specify the location of the deleted vault:
# Remove-AzureRmKeyVault -VaultName $keyVaultName -InRemovedState -Location $location

# Here's how you would delete a key:
# Remove-AzureKeyVaultKey -VaultName $keyVaultName -Name "MyKeyName"