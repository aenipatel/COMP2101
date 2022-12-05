# system information powershell script

param(
[string] $type = ''
)

if($type -eq ''){
    Write-Host "======================================="
    Write-Host "System Hardware Description: " 
    Write-Host "======================================="
    
    hardwareDesc 

    Write-Host "======================================="
    Write-Host "Operating System Name/Version: "
    Write-Host "======================================="

    operatingSystem

    Write-Host "======================================="
    Write-Host "Processor Description: "
    Write-Host "======================================="

    processorDesc

    Write-Host "======================================="
    Write-Host "RAM Details: "
    Write-Host "======================================="

    ramInfo 

    Write-Host "======================================="
    Write-Host "Disk Details: " Test
    Write-Host "======================================="

    diskInfo 

    Write-Host "======================================="
    Write-Host "Network-Adapter Configuration: "
    Write-Host "======================================="

    ipConfiguration 

    Write-Host "======================================="
    Write-Host "Video Configuration: "
    Write-Host "======================================="

    videoConfiguration 
    }
    else
    {
    if($type -eq 'System')
        {

        Write-Host "======================================="
        Write-Host "System Hardware Description: " 
        Write-Host "======================================="

        hardwareDesc 

        Write-Host "======================================="
        Write-Host "Operating System Name/Version: "
        Write-Host "======================================="

        operatingSystem

        Write-Host "======================================="
        Write-Host "Processor Description: "
        Write-Host "======================================="

        processorDesc

        Write-Host "======================================="
        Write-Host "RAM Details: "
        Write-Host "======================================="

        ramInfo 

        Write-Host "======================================="
        Write-Host "Video Configuration: "
        Write-Host "======================================="

        videoConfiguration 

        }
        else
        {
        if($type -eq 'Disks')
            {

            Write-Host "======================================="
            Write-Host "Disk Details: " Test
            Write-Host "======================================="

            diskInfo 

            }
            else
            {
            if($type -ieq 'Network')
                {
                Write-Host "======================================="
                Write-Host "Network-Adapter Configuration: "
                Write-Host "======================================="

                ipConfiguration 
                }
                else
                {
                    Write-Host "invalid Option! please try again"
                }
            }
        }
    }
