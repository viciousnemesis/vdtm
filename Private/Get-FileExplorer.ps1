function Get-FileExplorer {
    #TODO: Not Finished. Is this possible?
    $MsgBox::Show("Starting Get-FileExplorer...")
    $FileExplorer = [System.Collections.ArrayList]@()
    (New-Object -ComObject 'Shell.Application').Windows() | ForEach-Object { 
        $LocalPath = $_.Document.Folder.Self.Path 
        $FileExplorer.Add("C:\WINDOWS\explorer.exe /e, `"$LocalPath`"")
      }
    return $FileExplorer
}