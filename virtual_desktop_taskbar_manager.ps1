# This script is designed to work in conjunction with Dexpot, allowing users to control
# which shortcuts should be pinned to the taskbar for every desktop they have. 

cls
Write-Host "Starting virtual_desktop_taskbar_manager.ps1"
Set-Location (Split-Path $MyInvocation.MyCommand.Path)
$config_file = ".\config.txt"
$add_pin = 'c:5386'
$remove_pin = 'c:5387'

function Get-Config
{
    Param (        
        $config
    )        
    $config = @{}
    $lineCount = 0
    $command = ''

    
    # Parse each lin of config file, and create a $config{command, parmArray} hashtable 
    Get-Content -Path $config_file | 
    ForEach-Object {
        
        $line = $_
        $lineCount += 1    
        switch -regex ($line){
            '^:(\d{1,2}|All|syspin|Dexpot_log).*$' {      
                # 'Commands: desktop number, ALL (desktops), Syspin.exe or Dexpot.log locations          
                if ($command -ne $matches[1]) {                    
                    $command = $matches[1]                    
                    $parmsArray = [System.Collections.ArrayList]@()
                    $config.add($command, $parmsArray)
                }                
            }           

            '^".*$' {           
                # Configuration values      
                if ($command -eq '') {
                    throw "ERROR: Unable to assign parameter, no command found, at line: ($($lineCount))"
                } 
                
                switch -regex ($command) {
                    '.*syspin|Dexpot_log.*' {                        
                        $config.($command).Add($line.replace('"',''))
                    }                       
                    Default{
                        $config.($command).Add($line)
                    }
                }                                                                 
            }

            '^\s*$' {
                #Ignore empty lines
            }

            Default{
                throw "ERROR: Unable to parse config.txt at line: ($($lineCount))"
            }

        }
    } | Out-Null

    
    if ($null -eq $config.Dexpot_log -or (-Not($config.Dexpot_log -match '^.*dexpot.log$'))) {throw "ERROR: configuration not found for :Dexpot_log"}
    if ($null -eq $config.syspin) {throw "ERROR: configuration not found for :syspin"}
    
    Clear-Content $config.Dexpot_log
   
    return $config
}

function Get-Desktop 
{
    Param (        
        $desktop
    )
    #Write-Host("Get-Desktop")
    Clear-Content $config.Dexpot_log
    
    $desktop = @{when = $null; old_desktop = $null; new_desktop = $null}    
    
        
    do {
        
        Get-Content -Path $config.Dexpot_log -Wait | 
        ForEach-Object {
            if ($_ -match "(?<when>\d{1,2}:\d{1,2}:\d{1,2}).*Desktopwechsel von (?<old_desktop>\d{1,2}) nach (?<new_desktop>\d{1,2}).*") {                                 
                $desktop.when = $Matches.when                
                $desktop.old_desktop = $Matches.old_desktop
                $desktop.new_desktop = $Matches.new_desktop                
                break                 
            } 

        } | Out-Null
    } while ($false) # dummy loop so that `break` can be used.
    
    #Write-Object $desktop
    return $desktop
}

function Write-Object{
    Param (        
        $hash
    )
    Write-host 'Object:'
    foreach ($h in $hash.GetEnumerator()) {
        Write-Host "   $($h.Name): $($h.Value)"
    }
}

function Get-FileExplorer {
    $fileExplorer = [System.Collections.ArrayList]@()
    (New-Object -ComObject 'Shell.Application').Windows() | ForEach-Object { 
        $localPath = $_.Document.Folder.Self.Path 
        $fileExplorer.Add("C:\WINDOWS\explorer.exe /e, `"$localPath`"")
      }
    return $fileExplorer
}



do {
    
    $config = Get-Config
    $desktop = Get-Desktop      
    #Write-Object -h $desktop

    if ($null -ne $desktop.when) {
        
        # Removes taskbar pinned items from old desktop        
        if ($config.ContainsKey($desktop.old_desktop) -and $config.($desktop.old_desktop).count -gt 0) {
            write-host $config.($desktop.old_desktop).count
            write-host ''
            write-host 'Removing pins:'
            write-host '--------------'
            $config.($desktop.old_desktop) | ForEach-Object {
                write-host $config.syspin @($_, $remove_pin)
                & $config.syspin @($_, $remove_pin)
            } 
        }

        # Adds taskbar pinned items for new desktop        
        if ($config.ContainsKey($desktop.new_desktop) -and $config.($desktop.new_desktop).count -gt 0) {
            write-host $config.($desktop.new_desktop).count
            write-host ''
            write-host 'Adding pins:'
            write-host '--------------'
            $config.($desktop.new_desktop) | ForEach-Object {
                write-host $config.syspin @($_, $add_pin)
                & $config.syspin @($_, $add_pin)
            } 
        }
    } 
    
} while ($true)  




