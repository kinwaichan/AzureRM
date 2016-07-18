 Set-Location C:\Users\sshay\Documents\GitHub\AzureRM\ub-node

$ResourceGroupName = 'AzureRM'
$Location = 'East US 2'
$VnetName = "AzureRmVNet"
$SubNetIndex = 0

$StorageAccountName = "azurestoragez1"
$BaseImage = "https://azurestoragez1.blob.core.windows.net/system/Microsoft.Compute/Images/vm-images/ub-16.04.0-lts-16-07-13-osDisk.7785b3cd-e2b8-4dcd-a449-aa31778a3d89.vhd"


#Build Images 

$i = 1
For ($i=1; $i -lt 3; $i++) {

    $VitualMachine = @{
       ResourceGroupName = $ResourceGroupName;
       Location = $Location;
       StorageAccountName = $StorageAccountName;
       VnetName = $VnetName;  
       SubnetIndex = $SubNetIndex;
       VmName = "ub-client-$i";
       NicName = "ub-client-nic-$i"
       VmSize = "Standard_D1_v2"
       BaseImage = $BaseImage
       };

   .  .\..\base\build-ub.ps1 @VitualMachine;
    
}



# Destroy Images 

$i = 1
For ($i=1; $i -lt 3; $i++) {
   
   $VitualMachine = @{
       ResourceGroupName = $ResourceGroupName;
       StorageAccountName = $StorageAccountName;
       VmName = "ub-client-$i";
       NicName = "ub-client-nic-$i"
       }; 

    #Stop-AzureRmVM -ResourceGroupName $VitualMachine.ResourceGroupName -Name $VitualMachine.VmName  -Force 
    #Remove-AzureRmVM -ResourceGroupName $VitualMachine.ResourceGroupName -Name $VitualMachine.VmName  -Force 
    #Remove-AzureRmNetworkInterface  -ResourceGroupName $VitualMachine.ResourceGroupName  -Name $VitualMachine.NicName  -Force 

    $storageContext = (Get-AzureRmStorageAccount -ResourceGroupName $VitualMachine.ResourceGroupName -AccountName $VitualMachine.StorageAccountName).Context
    $diskName = $VitualMachine.VmName + '-os-disk.vhd';
    #Remove-AzureStorageBlob -Blob $diskName -Container vhds -Context $storageContext  -Force 

} 
 
