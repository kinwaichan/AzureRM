Login-AzureRMAccount

$ResourceGroupName = 'AzureRM'
$Location = 'East US 2'
$VnetName = "AzureRmVNet"

##Storage account name must be between 3 and 24 characters in length and use numbers and lower-case letters only
$StorageAccountName = "azurestoragez1"

New-AzureRmStorageAccount -Name $StorageAccountName -ResourceGroupName $ResourceGroupName `
                          -Type Standard_LRS -Location $Location

