cls
function global:Get-SystemInfo { 
 
#Requires -Version 3.0 
[CmdletBinding()] 
 Param  
   ( 
    [Parameter(Position=0, 
               ValueFromPipeline=$true, 
               ValueFromPipelineByPropertyName=$true)] 
    [String[]]$ComputerName = ($Env:COMPUTERNAME), 
    [Parameter(Position=1)] 
    [PSCredential]$Credential, 
    [ValidateScript({Test-Path -Path $_})] 
    [String]$LogDir = "$Home\Documents"         
   )#End Param  
 
Begin 
{ 
 Write-Verbose "Retrieving Computer Info . . ." 
 if ($Credential) 
    { 
        $PSDefaultParameterValues = $Global:PSDefaultParameterValues.Clone() 
        $PSDefaultParameterValues["Get-WmiObject:Credential"]=$Credential   
    } 
} 
Process 
{ 
    $ComputerName | ForEach-Object {  
 
    Write-Verbose ">> ComputerName: $_" 
 
    $ErrorActionPreference = "SilentlyContinue" 
     
    $os = Get-WmiObject -class Win32_OperatingSystem -ComputerName $_ 
     
    $sys = Get-WmiObject -Class win32_Computersystem -ComputerName $_ 
     
    $bios = Get-WmiObject -Class win32_Bios -ComputerName $_  
     
    $PageFile = Get-WmiObject Win32_PageFileSetting -ComputerName $_ |  
        Select Name, InitialSize, MaximumSize | Format-Table -AutoSize | Out-String 
     
    $Volume = Get-VolumeWin32 -ComputerName $_ |  
        Select Name,VolumeName,CapacityGB,UsedGB,FreeGB,FreePC |  
        ft -AutoSize | Out-String 
     
    $Network = (Get-WmiObject -class win32_NetworkAdapterConfiguration -ComputerName $_  |  
        ForEach-Object { $_.DefaultIPGateway } | Out-String).Split("`n")[0] 
     
    $CPU = @(Get-WmiObject -Class Win32_Processor -ComputerName $_ )[0] 
 
    if (($os -eq $Null) -and ($sys -eq $Null) -and ($bios -eq $Null)) 
        { 
          $_ | Out-File -FilePath $LogDir\nowmiHosts.txt -noclobber -Append 
        } 
 
    if ($os.LastBootupTime) 
        { 
        $LastBoot = $os.ConvertToDateTime($os.LastBootupTime) 
        } 
    if ($os.InstallDate) 
        { 
        $InstallDate = $os.ConvertToDateTime($os.InstallDate) 
        } 
    if ($sys.Name) 
        { 
        $CompName = $sys.Name.toUpper() 
        } 
    if ($sys.TotalPhysicalMemory) 
        { 
        $Memory=($sys.TotalPhysicalMemory)/1MB -as [int] 
        } 
    if ($Volume) 
        { 
            $Volume = $Volume.Substring(2,$Volume.length-9) 
        } 
    else 
        { 
            $Volume = @" 
Please download and dot source the following function: 
>> http://gallery.technet.microsoft.com/scriptcenter/74884d85-c0b5-446a-be04-3d411a6dce2f 
"@ 
        } 
 
    if ($Pagefile) 
        { 
            $PageFile = $PageFile.Substring(1,$PageFile.length-5) 
        } 
    else {$PageFile = "Automatic"} 
 
    [PSCustomObject][Ordered]@{  
        Computername   =$CompName  
        OperatingSystem=$os.Caption 
        OSVersion      =$os.Version 
        OSArchitecture =$os.OSArchitecture 
        CPUName        =$CPU.Name 
        CPUDescription =$CPU.Description 
        CPUAddressWidth=$CPU.AddressWidth 
        WindowsDir     =$os.WindowsDirectory 
        LastBoot       =$LastBoot 
        InstallDate    =$InstallDate 
        BiosVersion    =$bios.version  
        SerialNumber   =$bios.SerialNumber 
        TotalPhysMemMB =$Memory 
        Vendor         =$sys.Manufacturer  
        Model          =$sys.Model 
        Owner          =$sys.PrimaryOwnerName 
        DefaultGateway =$Network 
        PageFileInfo   =$PageFile 
        Volume         =$Volume 
        } 
     
    $ErrorActionPreference = "Continue" 
     
    # The following used for testing.  
    #$LastBoot,$InstallDate,$os,$sys,$bios,$CompName,$InstallDate,$LastBoot,$Memory,$PageFile,$Volume = $Null 
      
  } 
 
} 
 
}#Get-SystemInfo 
function Global:Get-VolumeWin32 { 
      [CmdletBinding()] 
      Param ( 
            [Parameter(Position=1, 
                       ValueFromPipeline=$true, 
                       ValueFromPipelineByPropertyName=$true)] 
            [String[]]$ComputerName = $env:COMPUTERNAME 
      )#End Param 
      Begin 
      { 
            $Query = "Select SystemName,Name,VolumeName,Size,DriveType,FreeSpace from Win32_LogicalDisk WHERE DriveType = '3'" 
            $NameSpace = "root\cimv2" 
            Write-Verbose "Retrieving Volume Info . . ." 
            Write-Verbose $Query 
            Write-Verbose "from NameSpace: $NameSpace `n" 
      } 
      Process 
      { 
             
            $ComputerName | foreach-object { 
                  $Computer = $_ 
                  Write-Verbose "Connecting to:--> $Computer" 
                   
                  try { 
                        Get-WmiObject -Query $Query -Namespace $NameSpace -ComputerName $Computer -ErrorAction Stop | 
                        Where-Object {$_.name -notmatch "\\\\" -and $_.DriveType -eq "3"} | 
                        ForEach-Object {$RAW = $_ | Select-Object -Property SystemName,Name,VolumeName,Size,FreeSpace ; Write-Verbose $RAW ; $_ } | 
                        Select-Object SystemName, Name, VolumeName, 
                        @{name="CapacityGB";Expression={"{0:N2}"  -f ($_.size / 1gb)}}, 
                        @{name="UsedGB";Expression={"{0:N2}"  -f ($($_.size-$_.freespace) / 1gb)}}, 
                        @{name="FreeGB";Expression={"{0:N2}"  -f ($_.freespace / 1gb)}}, 
                        @{name="FreePC";Expression={"{0:N2}"  -f ($_.freespace / $_.size * 100)}} | Sort-Object SystemName,Name  
                  } 
                  Catch { 
                        Write-Warning "$Computer : $_" 
                  } 
            }#Foreach-Object(ComputerName) 
      }  
       
}#Get-VolumeWin32

Get-SystemInfo
$strComputer = "LENOVO-PC" 
 
$colItems = get-wmiobject -class "Win32_PnPEntity" -namespace "root\CIMV2" ` -computername $strComputer 
 
foreach ($objItem in $colItems) { 
      write-host "Availability: " $objItem.Availability 
      write-host "Caption: " $objItem.Caption 
      write-host "Class GUID: " $objItem.ClassGuid 
      write-host "Configuration Manager Error Code: " $objItem.ConfigManagerErrorCode 
      write-host "Configuration Manager User Configuration: " $objItem.ConfigManagerUserConfig 
      write-host "Creation Class Name: " $objItem.CreationClassName 
      write-host "Description: " $objItem.Description 
      write-host "Device ID: " $objItem.DeviceID 
      write-host "Error Cleared: " $objItem.ErrorCleared 
      write-host "Error Description: " $objItem.ErrorDescription 
      write-host "Installation Date: " $objItem.InstallDate 
      write-host "Last Error Code: " $objItem.LastErrorCode 
      write-host "Manufacturer: " $objItem.Manufacturer 
      write-host "Name: " $objItem.Name 
      write-host "PNP Device ID: " $objItem.PNPDeviceID 
      write-host "Power Management Capabilities: " $objItem.PowerManagementCapabilities 
      write-host "Power Management Supported: " $objItem.PowerManagementSupported 
      write-host "Service: " $objItem.Service 
      write-host "Status: " $objItem.Status 
      write-host "Status Information: " $objItem.StatusInfo 
      write-host "System Creation Class Name: " $objItem.SystemCreationClassName 
      write-host "System Name: " $objItem.SystemName 
      write-host 
} 