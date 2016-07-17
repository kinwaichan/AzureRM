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
$storageAccountKey = (Get-AzureRmStorageAccountKey -ResourceGroupName $ResourceGroupName -AccountName $StorageAccountName).Value[0]

write-output("File Uri:" + $fileUri)
write-output("Primary StorageKey:" + $storageAccountKey)


#Blob Storage Container
 $publicConfig = '{
    "Mode": "Push",
    "FileUri": $fileUri
  }'


 $privateConfig = '{
  "StorageAccountName": $StorageAccountName,
  "StorageAccountKey": $storeageKey
  }'


#Set-AzureRmVMExtension -ResourceGroupName $ResourceGroupName -VMName $VmName -Location $Location `
 #                      -Name $extensionName -Publisher $publisher -ExtensionType $extensionName `
  #                     -TypeHandlerVersion $version -SettingString $publicConfig -ProtectedSettingString $privateConfig

