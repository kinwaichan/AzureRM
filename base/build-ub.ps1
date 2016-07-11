Param
(
    [Parameter(Mandatory=$true)]
    [String] 
    $ResourceGroupName,    

    [Parameter(Mandatory=$true)]
    [String] 
    $Location,

    [Parameter(Mandatory=$true)]
    [String] 
    $StorageAccountName,

    [Parameter(Mandatory=$true)]
    [String] 
    $VnetName,    
    
    [Parameter(Mandatory=$true)]
    [Int] 
    $SubnetIndex,

    [Parameter(Mandatory=$true)]
    [String] 
    $VmSize,


    [Parameter(Mandatory=$true)]
    [String] 
    $VmName,

    [Parameter(Mandatory=$true)]
    [String] 
    $NicName


)

# Docker Base Update 5/09/2016
##$ubImageUri =    "https://storageautomation01.blob.core.windows.net/system/Microsoft.Compute/Images/vm-images/ub-docker-osDisk.da9731ee-aed1-42f0-bda1-518b584f8296.vhd"

#########################################
# Docker Base Update 14.4 LTS  - 5/16/2016
#$ubImageUri =  "https://storageautomation01.blob.core.windows.net/system/Microsoft.Compute/Images/vm-images/ub-docker-base-14.4-osDisk.849a94a0-0518-484c-9c4e-5d550ebf518a.vhd"

#Docker Base Update 5/16/2016 14.4 LTS Ver 2 - Current
#$ubImageUri =  "https://storageautomation01.blob.core.windows.net/system/Microsoft.Compute/Images/vm-images/ub-docker-base-14.4-V2-osDisk.d4f0e158-a549-43de-9cad-fc932159c382.vhd"


#########################################
# Docker Base Update - 15.0.4
# 5/15/2016 
# $ubImageUri =  "https://storageautomation01.blob.core.windows.net/system/Microsoft.Compute/Images/vm-images/ub-docker-base-01-osDisk.1b8db4ee-08f0-4d83-9300-861a8f07a74b.vhd"

# 5/18/2016
$ubImageUri =  "https://storageautomation01.blob.core.windows.net/system/Microsoft.Compute/Images/vm-images/ub-docker-base-15.4-V2-osDisk.332b41d1-b94e-4ba0-abe6-5584505d5717.vhd"



#$ubImageUri =  "https://storageautomation01.blob.core.windows.net/system/Microsoft.Compute/Images/vm-images/ub-docker-base-15.4-V3-osDisk.ae66f9a9-36a7-40db-b3e0-67a00985baa0.vhd"


# VM Credentials
$username = "Navigator"
$password = ConvertTo-SecureString "Navigator2016" -AsPlainText -Force
$cred = New-Object -TypeName System.Management.Automation.PSCredential `
                   -ArgumentList $username, $password

# Vnet
$vnet = Get-AzureRmVirtualNetwork -Name $VnetName -ResourceGroupName $ResourceGroupName
write-output("VnetName:" + $vnet.Name.ToString())

# Storage Account
$storageAccount = Get-AzureRmStorageAccount -ResourceGroupName $ResourceGroupName -Name $StorageAccountName
write-output("StorageAccountName:" + $StorageAccountName + "Id:" + $storageAccount.Id) 


# Nic
$nic = New-AzureRmNetworkInterface -ResourceGroupName $ResourceGroupName `
                                   -Name $NicName  -Subnet $vnet.Subnets[$SubnetIndex] -Location $Location 


# VM
$vm = New-AzureRmVMConfig -VMName $VmName -VMSize $VmSize
$vm = Add-AzureRmVMNetworkInterface -VM $vm -Id $nic.Id
$vm = Set-AzureRmVMOperatingSystem -VM $vm -Linux  -ComputerName $VmName -Credential $cred 


# VM Disk
$diskName = $VmName + "-os-disk"
$osDiskUri = $storageAccount.PrimaryEndpoints.Blob.ToString() + "vhds/" + $diskName  + ".vhd"
$vm = Set-AzureRmVMOSDisk -VM $vm -Name $diskName   -VhdUri $osDiskUri  -CreateOption fromImage -SourceImageUri $ubImageUri  -Linux

# Create VM
New-AzureRmVM -ResourceGroupName $ResourceGroupName -Location $Location -VM $vm -Verbose  