## Azure Resource Manager 

###Prerequisites

Windows 8.1 and Below   
Windows Management Framework 5.0   
https://www.microsoft.com/en-us/download/details.aspx?id=50395


Azure PowerShell 1.0   
https://azure.microsoft.com/en-us/documentation/articles/powershell-install-configure/

Powershell ISE Project Explorer    
https://gallery.technet.microsoft.com/Powershell-ISE-Explorer-bfc92307

The Powershell Execution Policy is required to be set before adding the plugin

````
  Set-ExecutionPolicy  Unrestricted
````
###Tools

Microsoft Azure Storage Explorer
http://storageexplorer.com/

###Setup 

####resourceGroup.ps1

This Script will setup the Resource Group and Networking Foundation.   

|   			|   			  |
|---------------|-----------------|
|Resource Group |AzureRM          |
|Network        |192.168.0.0/16   |

#### Subnets
|   			  |   			    |
|-----------------|-----------------|
|FrontEnd         |192.168.1.0/24   |
|BackEnd          |192.168.2.0/24   |
|Client Network   |192.168.3.0/24   |

####storage.ps1
