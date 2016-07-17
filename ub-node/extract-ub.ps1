Login-AzureRMAccount

$ResourceGroupName = 'AzureRM'
$StorageAccountName = "azurestoragez1"

$i = 0
$vmName = 'ub-client-'+ $i
$nicName = 'ub-client-nic-' + $i
$diskName = $vmName + '-os-disk.vhd';

$vhdNamePrefix = 'ub-16.04.0-lts-16-07-13'
$path = $vhdNamePrefix + ".json"

# Verify and Run waagent on Host

#Linux Server 
Stop-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $vmName
Set-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $vmName -Generalized
Save-AzureRmVMImage -ResourceGroupName $ResourceGroupName -Name $vmName -DestinationContainerName "vm-images" -VHDNamePrefix $vhdNamePrefix -Path $path

# Remove Resources
Remove-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $vmName
Remove-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $ResourceGroupName -Force 


#Remove VHD Disk
$storageContext = (Get-AzureRmStorageAccount -ResourceGroupName $ResourceGroupName -AccountName $StorageAccountName).Context
Remove-AzureStorageBlob -Blob $diskName -Container vhds -Context $storageContext

