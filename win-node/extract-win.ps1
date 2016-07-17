Login-AzureRMAccount

$ResourceGroupName = 'AzureRM'

$vmName = 'win-server-1'
$nicName = $vmName + "nic";

$vhdNamePrefix = 'win-2012-R2-Datacenter-16-07-13'
$path = $vhdNamePrefix + ".json"

#Windows Server - after sysprep
Stop-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $vmName
Set-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $vmName -Generalized
Save-AzureRmVMImage -ResourceGroupName $ResourceGroupName -Name $vmName -DestinationContainerName "vm-images" -VHDNamePrefix $vhdNamePrefix -Path $path


# Remove Resources
Remove-AzureRmNetworkInterface -Name $nicName -ResourceGroupName $ResourceGroupName -Force 
Remove-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $vmName