# sign in
Write-Output "Logging in...";
# Connect-AzureRmAccount

# Select Subscription
$subscriptionName = 'SubName'
Select-AzureRmSubscription -SubscriptionName $subscriptionName

# Configure Variables
$deploymentMode = 'Incremental'
$resourceGroupName = 'RG-'
$templateBasePath = "C:\srcARM\Azure-Infrastructure\AppServicePlan-Standard\"
$templateFilePath = $templateBasePath + "azuredeployAppServicePlanStandard_v1_0_0.json"
$parametersFilePath = $templateBasePath + "azuredeployAppServicePlanStandard_v1_0_0.parameters.json"

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
