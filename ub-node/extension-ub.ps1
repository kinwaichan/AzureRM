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


$extensionName = 'DSCForLinux'
$publisher = 'Microsoft.OSTCExtensions'
$version = '2.0'


# MOF File in Blob Storage - Directory/File Must be in place
$fileDirectory = 'mof'
$mofFile = 'localhost.mof'
$fileUri = "http://$StorageAccountName.blob.core.windows.net/$fileDirectory/$mofFile";

write-output("PrimaryLocation:" + $fileUri)


#Blob Storage Container
 $publicConfig = '{
    "Mode": "Push",
    "FileUri": $fileUri
  }'


 $privateConfig = '{
  "StorageAccountName": $StorageAccountName,
  "StorageAccountKey": "+lGXy5tRPD9E3hbFqqTp+6/mNhYswZeeInjlhNL0cg8JsP3ezgegtw+3OQr9DY9mjoKccv9dpDZzsSv6AKb4BA=="
  }'









$StorageAccount = Get-AzureRmStorageAccount -ResourceGroupName $ResourceGroupName -AccountName $StorageAccountName





##write-output("PrimaryLocation:" + $StorageAccount.PrimaryEndpoints) 
##write-output("PrimaryLocation:" + $StorageAccount) 



 
















#Set-AzureRmVMExtension -ResourceGroupName $ResourceGroupName -VMName $VmName -Location $Location `
 #                      -Name $extensionName -Publisher $publisher -ExtensionType $extensionName `
  #                     -TypeHandlerVersion $version -SettingString $publicConfig -ProtectedSettingString $privateConfig

