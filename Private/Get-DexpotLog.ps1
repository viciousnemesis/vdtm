function Get-DexpotLog 
{
    [cmdletbinding()]
    Param (        
        $Desktop
    )

    $Desktop = @{When = $null; OldDesktop = $null; NewDesktop = $null}    
    
    Clear-Content $global:Config.DexpotLog
       
    do {

        #Read the Dexpot log, e.g. to identify when a desktop has changed, or is completed a desktop change
        Get-Content -Path $global:Config.DexpotLog -Wait | 
        ForEach-Object {
            
            $Line = $_
            switch -regex ($Line) {
                
                '(?<When>\d{1,2}:\d{1,2}:\d{1,2}).*Desktopwechsel von (?<OldDesktop>\d{1,2}) nach (?<NewDesktop>\d{1,2}).*'{                                                     
                    #Desktop change started
                    $Desktop.When = $Matches.When 
                    $Desktop.OldDesktop = $Matches.OldDesktop
                    $Desktop.NewDesktop = $Matches.NewDesktop    
                } 

                '(?<when>\d{1,2}:\d{1,2}:\d{1,2}).*Desktopwechsel abgeschlossen.*$' {
                    if (Set-Desktop -DesktopNumber $Desktop.NewDesktop) {
                        break
                    }
                }
            }

        } | Out-Null
    } while ($false) # dummy loop so that `break` can be used.
    
    #Write-Object $Desktop
    return $Desktop
}