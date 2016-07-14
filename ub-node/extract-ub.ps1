Login-AzureRMAccount

$ResourceGroupName = 'AzureRM'

$vmName = 'ub-client-1'
$vhdNamePrefix = 'ub-16.04.0-lts-16-07-13'
$path = $vhdNamePrefix + ".json"


Stop-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $vmName
Set-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $vmName -Generalized
Save-AzureRmVMImage -ResourceGroupName $ResourceGroupName -Name $vmName -DestinationContainerName "vm-images" -VHDNamePrefix $vhdNamePrefix -Path $path

## TODO Remove NIC
Remove-AzureRmVM -ResourceGroupName $ResourceGroupName -Name $vmName