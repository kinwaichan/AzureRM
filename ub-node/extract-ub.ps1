Login-AzureRMAccount

$ResourceGroupName = 'AzureRM'

$vmName = 'ub-client-1'
$nicName = $vmName + "nic";

$vhdNamePrefix = 'ub-16.04.0-lts-16-07-13'
$path = $vhdNamePrefix + ".json"

#Linux Server - Run waagent on Host
Stop-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $vmName
Set-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $vmName -Generalized
Save-AzureRmVMImage -ResourceGroupName $ResourceGroupName -Name $vmName -DestinationContainerName "vm-images" -VHDNamePrefix $vhdNamePrefix -Path $path

# Remove Resources
Remove-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $ResourceGroupName -Force 
Remove-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $vmName

#Remove Disk
