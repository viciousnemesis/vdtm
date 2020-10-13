function Set-Desktop {
    [cmdletbinding()]
    Param (                
        $DesktopNumber
    )

    #Desktop change completed                       
    Write-LayoutXML -DesktopNumber $DesktopNumber
    
    #confirm copy happened as expected
    if (Confirm-LayoutUpdated -DesktopNumber $DesktopNumber) {
        & taskkill /f /im explorer.exe
        & Start-Process explorer.exe
        #$MsgBox::Show("Success!")
        Return $True        

    }  else {
        #$MsgBox::Show("FAIL!")
        Return $False
    }     
}