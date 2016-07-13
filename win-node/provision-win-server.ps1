Login-AzureRMAccount
Set-Location C:\Users\sshay\Documents\GitHub\AzureRM\win-node

$ResourceGroupName = 'AzureRM'
$Location = 'East US 2'
$VnetName = "AzureRmVNet"
$SubNetIndex = 2

$StorageAccountName = "azurestoragez1"


$i = 1
For ($i=1; $i -lt 2; $i++) {
  $VitualMachine = @{
       ResourceGroupName = $ResourceGroupName;
       Location = $Location;
       StorageAccountName = $StorageAccountName;
       VnetName = $VnetName;
       SubnetIndex = $SubnetIndex;
       VmName = "win-client-$i";
       NicName = "win-client-nic-$i";
       VmSize = "Standard_D1_v2";
       };

    . .\..\base\build-win-client.ps1 @VitualMachine;

}


