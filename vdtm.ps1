
#This is the script that is called by the Windows Task Scheduler, to force elevated permissions
Import-Module $PSScriptRoot\vdtm.psm1


#Old method below, just in case we need this again
#$command = @"
#powershell.exe -Command "& {Import-Module $($PWD)\vdtm.psm1}" 2> '$($PWD)\errors.txt' | Tee-Object -FilePath '$($PWD)\vdtm.log -noexit
#"@
# -file '$($dir)\vdtm.ps1' 2> '$($dir)\errors.txt' | Tee-Object -FilePath '$($dir)\vdtm.log'



#Dot source the files to import
#$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
#$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
#$Config = @( Get-ChildItem -Path $PSScriptRoot\Config\*.ps1 -Recurse -ErrorAction SilentlyContinue )
#Foreach($Import in @($Public + $Private + $Config))
#{
#    Try
#    {
#        $MsgBox::Show("IMPORT: $($Import)")
#        . $Import.fullname
#    }
#    Catch
#    {
#        $MsgBox::Show("ERROR Failed to import function $($Import.fullname): $_")        
#    }
#}



#Run Command, and display error if one occurs
#$error.clear()
#PowerShell -command ("$($command)");


#if ($null -ne $error) {
#    $MsgBox::Show($command + "`n" + $error)
#}
#$error.clear()