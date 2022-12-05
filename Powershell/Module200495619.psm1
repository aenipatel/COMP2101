# 1) Get system hardware description

function hardwareDesc {
	$HardwareDescription = Get-WmiObject win32_computersystem
	$HardwareDescription
}


# 2) Get operating system name and version number
function operatingSystem{
$OS = Get-WmiObject -Class Win32_OperatingSystem
if($OS){
    $OSName = $OS.Name
    $OSVersion = $OS.Version
    
    Write-Host "Name	: $OSName"
    Write-Host "Version	: $OSVersion"
}
else{
    Write-Host "Name	: Data Unavailable"
    Write-Host "Version	: Data Unavailable"
}
}


# 3) Get processor description with speed, number of cores, and sizes of the L1, L2, and L3 caches if they are present

function processorDesc{
$SystemInfo = Get-WmiObject -Class Win32_Processor 

"Description	: $($SystemInfo.Name)"
"Speed		: $($SystemInfo.MaxClockSpeed) MHz"
"NumberOfCores	: $($SystemInfo.NumberOfCores)"

if ($SystemInfo.L1CacheSize -ne $null){
    "L1CacheSize	: $($SystemInfo.L1CacheSize) KB"
}else {
    "L1CacheSize	: Data Unavailable"
}
if ($SystemInfo.L2CacheSize -ne $null){
    "L2CacheSize	: $($SystemInfo.L2CacheSize) KB"
}else {
    "L2CacheSize	: Data Unavailable"
}

if ($SystemInfo.L3CacheSize -ne $null){
    "L3CacheSize	: $($SystemInfo.L3CacheSize) KB"
}else {
    "L3CacheSize	: Data Unavailable"
}

}

# 4) Get a summary of the RAM installed with the vendor, description, size, and bank and slot for each DIMM as a table

function ramInfo {
$RAMInfo = Get-CimInstance win32_PhysicalMemory
$Table = @()
foreach ($item in $RAMInfo){
    $Object = New-Object -TypeName PSObject
    $Object | Add-Member -MemberType NoteProperty -Name Vendor -Value ($item.Manufacturer -replace '^\s*')
    $Object | Add-Member -MemberType NoteProperty -Name Description -Value ($item.PartNumber -replace '^\s*')
    $Object | Add-Member -MemberType NoteProperty -Name Size -Value ($item.Capacity/1GB)
    $Object | Add-Member -MemberType NoteProperty -Name Bank -Value ($item.BankLabel -replace '^\s*')
    $Object | Add-Member -MemberType NoteProperty -Name Slot -Value ($item.DeviceLocator -replace '^\s*')
    $Table += $Object
}
$Table | Format-Table -Auto
$TotalRAM = ($RAMInfo | Measure-Object -Property Capacity -Sum).Sum/1GB
Write-Host "Total RAM Installed: $TotalRAM GB"
}


# 5) Get disk information

function diskInfo {
$diskdrives = Get-CIMInstance CIM_diskdrive
$table = @()
foreach ($disk in $diskdrives) {
    $partitions = $disk|get-cimassociatedinstance -resultclassname CIM_diskpartition
    foreach ($partition in $partitions) {
          $logicaldisks = $partition|get-cimassociatedinstance -resultclassname CIM_logicaldisk
          foreach ($logicaldisk in $logicaldisks) {
                   $obj = new-object -typename psobject -property @{Vendor=$disk.Manufacturer
                                                             Model=$disk.Model
                                                             "freeSpace(GB)"=$logicaldisk.FreeSpace / 1gb -as [int]
                                                             "Size(GB)"=$logicaldisk.size / 1gb -as [int]
							     "percentFree(%)"=($logicalDisk.FreeSpace/$disk.Size)*100 -as [int]
                                                             }
	$table += $obj 
         }
    }
}
$table | Format-Table -Autosize
}

# 8) Welcome function from profile

function welcome {
write-output "Welcome to planet Windows10 Overlord Aenip"
$now = get-date -format 'HH:MM tt on dddd'
write-output "It is $now."
}


# 9) get cpuinfo function from profile
function get-cpuinfo {
get-ciminstance -class cim_processor | 
format-list Manufacturer, Name, CurrentClockSpeed, MaxClockSpeed, NumberOfCores |
more
}


# 10) get mydisks function from profile
function get-mydisks {
new-object -typename psobject -property @{Manufacturer=(get-disk).Manufacturer; 
Model=(get-disk).Model; 
Serial_Number=(get-disk).SerialNumberl; 
Firmware_revision=(get-disk).FirmwareRevision; 
Size=(get-disk).Size}
}

# 6) Get Ip configuration

function ipConfiguration {

get-ciminstance win32_networkadapterconfiguration | 
Where IPEnabled -eq True |
format-table -Auto Description, Index, IPAddress, IPSubnet, DNSDomain, DNSServerSearchOrder

}

# 7) Get Video Configuration

function videoConfiguration {
$videoController = Get-WmiObject -Class Win32_VideoController

if($videoController) {
    $vendor = $videoController.adaptercompatibility
    $desc = $videoController.description
    $resolution = $videoController.CurrentHorizontalResolution.ToString() + 'x' + $videoController.CurrentVerticalResolution.ToString()
    "Vendor		: $vendor"
    "Description	: $desc"
    "Resolution	: $resolution"

} else {
    Write-Host "Data unavailable"
}
}

