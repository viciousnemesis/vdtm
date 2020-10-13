function Confirm-LayoutUpdated {

    [cmdletbinding()]
    Param (        
        $DesktopNumber
    )        
    
    $DestinationFile = $global:Config.LayoutPath + $global:Config.LayoutFile
    $SourceFile = $global:Config.LayoutPath + $global:Config.LayoutFile.Replace('.xml','_' + $DesktopNumber + '.xml')

    $MD5 = New-Object -TypeName System.Security.Cryptography.MD5CryptoServiceProvider              
    $HashCurrent = [System.BitConverter]::ToString($MD5.ComputeHash([System.IO.File]::ReadAllBytes($DestinationFile)))
    $HashNewDesktopCopy = [System.BitConverter]::ToString($MD5.ComputeHash([System.IO.File]::ReadAllBytes($SourceFile)))

    if ($HashCurrent -eq $HashNewDesktopCopy) {
        #$MsgBox::Show("Layout successfully updated!")
        return $True
    } else {
        #$MsgBox::Show("Layout failed to update!")
        return $False
    }

}