Login-AzureRMAccount

$Location = 'East US 2'

#Windows 
Get-AzureRmVMImagePublisher -Location $Location | Select PublisherName | Out-GridView
Get-AzureRmVmImageOffer -Location $Location -PublisherName 'MicrosoftVisualStudio' | Out-GridView
Get-AzureRmVmImageSku -Location $Location -PublisherName 'MicrosoftVisualStudio' -Offer "Windows" | Out-GridView
Get-AzureRmVMImage -Location $Location -PublisherName "MicrosoftVisualStudio" -Offer "Windows" -Skus "10-Enterprise-N" | Out-GridView

$Publisher = (Get-AzureRmVMImagePublisher -Location "Central US") | select -ExpandProperty PublisherName | where { $_ -like '*Microsoft*Windows*Server' }
$Offer = (Get-AzureRmVMImageOffer -Location "Central US" -PublisherName $Publisher[0]) | select -ExpandProperty Offer | where { $_ -like '*Windows*' } 
$Sku = (Get-AzureRmVMImageSku -Location "Central US" -PublisherName $Publisher[0] -Offer $Offer[0]) | select -ExpandProperty Skus
$Versions = (Get-AzureRmVMImage -Location "Central US" -Offer -Offer $Offer[0] -PublisherName $Publisher[0] -Skus $Sku[0]) | select -ExpandProperty Version
$VMImage = Get-AzureRmVMImage -Location "Central US" -Offer -Offer $Offer[0] -PublisherName $Publisher[0] -Skus $Sku[0] -Version $Versions[0]
$VirtualMachine07 = Set-AzureRmVMSourceImage -VM $VirtualMachine07 -ImageReference $VMImage


#Canonical UbuntuServer
Get-AzureRmVMImagePublisher -Location $Location | Select PublisherName | Out-GridView
Get-AzureRmVmImageOffer -Location $Location -PublisherName 'Canonical' | Out-GridView
Get-AzureRmVmImageSku -Location $Location -PublisherName 'Canonical' -Offer "UbuntuServer" | Out-GridView
Get-AzureRmVMImage -Location $Location -PublisherName "Canonical" -Offer "UbuntuServer" -Skus "16.04.0-LTS" | Out-GridView

	
## Image Id 
/Subscriptions/09e01a7d-07d4-43ee-80c7-8b2c0d7ec41f/Providers/Microsoft.Compute/Locations/eastus2/Publishers/Canonical/ArtifactTypes/VMImage/Offers/UbuntuServer/Skus/16.04.0-LTS/Versions/16.04.201604203	

## Get Image Sizes 
Get-AzureRmVMSize –Location $Location |ft