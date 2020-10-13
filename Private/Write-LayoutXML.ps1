function Write-LayoutXML {
    #TODO
    [cmdletbinding()]
    Param (        
        $DesktopNumber
    )      
        
    #Start by copying empty Template to temp file: LayoutModification_$DesktopNumber.xml
    $TempFileName = $global:Config.LayoutFile.replace(".xml", "_$($DesktopNumber).xml")
    $TempFilePath = "$($global:Config.LayoutPath)$($TempFileName)"  
      
    Copy-Item -Path "$($Global:Config.ScriptPath)\Templates\LayoutModification.xml" -Destination $TempFilePath
        
    #Insert Applications to pin in XML temp file
    $TempFile = New-Object System.IO.StreamReader -Arg $TempFilePath
    $Output = ""
    While ($Line = $TempFile.ReadLine()) {            
        if ($Line -match "(?<Indentation>\s*)</taskbar:TaskbarPinList>.*") {            
            
            #Set Pinned apps for All Desktops
            $global:Config.Desktops.All.GetEnumerator() | ForEach-Object {
                $Path = $_.Value
                $Tag = "<taskbar:DesktopApp DesktopApplicationLinkPath=`"$($Path)`"/>"                    
                $Output += $Matches.Indentation + "  " + $Tag + $global:nl                     
            }

            #Set Pinned apps for current Desktop
            $global:Config.Desktops.("Desktop$($DesktopNumber)").GetEnumerator() | ForEach-Object {
                $Path = $_.Value
                $Tag = "<taskbar:DesktopApp DesktopApplicationLinkPath=`"$($Path)`"/>"                    
                $Output += $Matches.Indentation + "  " + $Tag + $global:nl                     
            }
        }
        $Output += $Line + $global:nl
    }
    $TempFile.Close()


    #Write temp file
    $Output | Out-File -FilePath $TempFilePath -Force
    
    #Copy temp file to LayoutModification.xml
    Copy-Item -Path $TempFilePath -Destination ($global:Config.LayoutPath+$global:Config.LayoutFile)
 }