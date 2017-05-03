
<#
.DESCRIPTION

This sample demonstrates how to copy Managed Disks to another subscription.
 
.NOTES

1. Before you use this sample, please install the latest version of Azure PowerShell from here: http://go.microsoft.com/?linkid=9811175&clcid=0x409
2. Provide the appropriate values for each variable. Note: The angled brackets should not be included in the values you provide.

#>

#Provide the subscription Id where snapshot will be created
$subscriptionId = 'dd80b94e-0463-4a65-8d04-c94f403879dc'

#Provide the name of your resource group where snapshot will be created. 
$resourceGroupName ='MDDemo'

#Provide the name of the snapshot
$snapshotName = 'Conotoso_snapshot_2'

#Provide the storage type for snapshot. PremiumLRS or StandardLRS.
$storageType = 'StandardLRS'

#Provide the Azure region (e.g. westus) where snapshot will be located.
#This location should be same as the storage account location where VHD file is stored 
#Get all the Azure location using command below:
#Get-AzureRmLocation
$location = 'westus'

#Provide the URI of the VHD file (page blob) in a storage account. Please not that this is NOT the SAS URI of the storage container where VHD file is stored. 
#e.g. https://contosostorageaccount1.blob.core.windows.net/vhds/contosovhd123.vhd
#Note: VHD file can be deleted as soon as Managed Disk is created.
$sourceVHDURI = 'https://contosostorageaccount1.blob.core.windows.net/vhds/contoso-um-vm120170302230408.vhd'

#Provide the resource Id of the storage account where VHD file is stored. 
#e.g. /subscriptions/6492b1f7-f219-446b-b509-314e17e1efb0/resourceGroups/MDDemo/providers/Microsoft.Storage/storageAccounts/contosostorageaccount1
$storageAccountId = '/subscriptions/6492b1f7-f219-446b-b509-314e17e1efb0/resourceGroups/MDDemo/providers/Microsoft.Storage/storageAccounts/contosostorageaccount1'

#You will be prompted to enter the email address and password associated with your account. Azure will authenticate and saves the credential information, and then close the window. 
Login-AzureRmAccount

#Set the context to the subscription Id where Managed Disk will be created
Select-AzureRmSubscription -SubscriptionId $SubscriptionId

$snapshotConfig = New-AzureRmSnapshotConfig -AccountType $storageType -Location $location -CreateOption Import -StorageAccountId $storageAccountId -SourceUri $sourceVHDURI 
 
New-AzureRmSnapshot -Snapshot $snapshotConfig -ResourceGroupName $resourceGroupName -SnapshotName $snapshotName
 