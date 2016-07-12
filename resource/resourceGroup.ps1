Login-AzureRMAccount

Get-AzureRmSubscription | Format-Table
Get-AzureRmSubscription | Out-GridView


$ResourceGroupName = 'AzureRM'
$Location = 'East US 2'
$VnetName = "AzureRmVNet"
$VNetAddressPrefix = "192.168.0.0/16"


#region Create Resource Group

$ResourceGroup = @{
    Name = $ResourceGroupName;
    Location = $Location;
    Force = $true;
}

New-AzureRmResourceGroup @ResourceGroup;

#Set ResourceGroup Properties
Set-AzureRmResourceGroup -Name $ResourceGroupName -Tag @{Name="Department";Value="IT"}

# Get Azure Resource Groups 
Get-AzureRmresourceGroup | Select ResourceGroupName
Get-AzureRmresourceGroup | Out-GridView


#endregion


#region Create VNet

$vnet = New-AzureRmVirtualNetwork -Name $VnetName -ResourceGroupName $ResourceGroupName -Location $Location -AddressPrefix $VNetAddressPrefix

#endregion


#region Create Subnets

$vnet = Get-AzureRmVirtualNetwork -ResourceGroupName $ResourceGroupName -Name $VnetName
Add-AzureRmVirtualNetworkSubnetConfig -Name FrontEnd -VirtualNetwork $vnet -AddressPrefix 192.168.1.0/24
Add-AzureRmVirtualNetworkSubnetConfig -Name BackEnd  -VirtualNetwork $vnet -AddressPrefix 192.168.2.0/24
Add-AzureRmVirtualNetworkSubnetConfig -Name ClientNetwork  -VirtualNetwork $vnet -AddressPrefix 192.168.3.0/24

Set-AzureRmVirtualNetwork -VirtualNetwork $vnet 


#endregion


#region Subnet Properties 

$index = 0

$vnet = Get-AzureRmVirtualNetwork -Name $VnetName  -ResourceGroupName $ResourceGroupName 
$vnet.Subnets[$index].Id 
$vnet.Subnets[$index].AddressPrefix
$vnet.Subnets[$index].Name

#endregion