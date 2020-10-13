
$Global:nl = [Environment]::NewLine
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Drawing") 
[void] [System.Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
$Global:MsgBox = [System.Windows.Forms.MessageBox]


#Get public and private function definition files.
$Public  = @( Get-ChildItem -Path $PSScriptRoot\Public\*.ps1 -ErrorAction SilentlyContinue )
$Private = @( Get-ChildItem -Path $PSScriptRoot\Private\*.ps1 -ErrorAction SilentlyContinue )
$Config = @( Get-ChildItem -Path $PSScriptRoot\Config\*.ps1 -Recurse -ErrorAction SilentlyContinue )

#Dot source the files to import
Foreach($Import in @($Public + $Private + $Config))
{
    Try
    {
        . $Import.fullname
    }
    Catch
    {
        $Global:MsgBox::Show("ERROR Failed to import function $($Import.fullname): $_")
        Write-Error -Message "Failed to import function $($Import.fullname): $_"
    }
}

# Export Public functions ($Public.BaseName) for WIP modules
Export-ModuleMember -Function $Public.Basename

#Start the script
Start-VDTM