# This script is designed to work in conjunction with Dexpot, allowing users to control
# which shortcuts should be pinned to the taskbar for every Desktop they have. 

function Start-VDTM {

    cls  #Here for VSCode terminal clearing, Clear-Host doesn't seem to work in VSCode

    Write-Host "Starting VDTM"   
   
    #Set-Desktop -DesktopNumber 1
    
    do {
        Get-DexpotLog              
    } while ($true)  
}



