Login-AzureRMAccount
Set-Location D:\Documents\GitHub\NavigatorDataStore\azure\runbook\ub-node

$ResourceGroupName = 'Navigator-Automation'
$Location = 'East US 2'
$VnetName = 'automation-net'
$SubNetIndex = 0

$StorageAccountName = "storageautomation01"


$i = 1
For ($i=1; $i -lt 4; $i++) {

    $VitualMachine = @{
       ResourceGroupName = $ResourceGroupName;
       Location = $Location;
       StorageAccountName = $StorageAccountName;
       VnetName = $VnetName;
       SubnetIndex = $SubNetIndex;
       VmName = "swarm-node-$i";
       NicName = "swarm-node-nic-$i"
       };

  .  .\..\base\build-ub-docker.ps1 @VitualMachine;

      
}