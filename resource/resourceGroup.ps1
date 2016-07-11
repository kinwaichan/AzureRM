Login-AzureRMAccount

Get-AzureRmSubscription | Format-Table
Get-AzureRmSubscription | Out-GridView
Get-Process | Out-GridView

$ResourceGroupName = 'AzureRM'
$Location = 'East US 2'


# Create Resource Group
$ResourceGroup = @{
    Name = $ResourceGroupName;
    Location = $Location;
    Force = $true;
}

New-AzureRmResourceGroup @ResourceGroup;

#Set ResourceGroup Properties
Set-AzureRmResourceGroup -Name Navigator-Automation -Tag @{Name="Department";Value="IT"}


# Get Azure Resource Groups 
Get-AzureRmresourceGroup | Select ResourceGroupName
Get-AzureRmresourceGroup | Out-GridView

$VnetName = "AzureRmVNet"
$AddressPrefix = "10.0.1.0/24"


#Create VNet
$vnet = New-AzureRmVirtualNetwork -Name $VnetName -ResourceGroupName $ResourceGroupName -Location $Location -AddressPrefix $AddressPrefix 


   







