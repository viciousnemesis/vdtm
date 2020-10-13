$global:Config = @{       
    
    ScriptPath = Resolve-Path -Path "$($PSScriptRoot)\..\"  #Script's root directory is one up from where this configuration file is
    DexpotLog = "$($env:APPDATA)\Dexpot\dexpot.log"
    #DexpotLog = "%AppData%\Dexpot\dexpot.log"
    LayoutPath = "$($env:LOCALAPPDATA)\Microsoft\Windows\Shell\"
    #LayoutPath = "%LocalAppData%\Microsoft\Windows\Shell\"
    LayoutFile = "LayoutModification.xml"
    DexpotAddPin = 'c:5386'
    DexpotRemovePin = 'c:5387'
    
    'Desktops' = @{
        'All' = @{
            'Pin0' = "C:\Program Files\Everything\Everything.exe"
            'Pin1' = "C:\Program Files (x86)\Google\Chrome\Application\chrome.exe" #--profile-directory=Default
            'Pin2' = "$($env:APPDATA)\Microsoft\Windows\Start Menu\Programs\System Tools\File Explorer.lnk"
            #'Pin2' = "%APPDATA%\Microsoft\Windows\Start Menu\Programs\System Tools\File Explorer.lnk"
            'Pin3' = "C:\Program Files\WindowsApps\45273LiamForsyth.PawsforTrello_2.11.7.0_x64__7pb5ddty8z1pa\app\Trello.exe"
            'Pin4' = "C:\Program Files\WindowsApps\SpotifyAB.SpotifyMusic_1.141.634.0_x86__zpdnekdrzrea0\Spotify.exe"
            'Pin5' = "C:\Program Files (x86)\Notepad++\notepad++.exe"
        }    
        
        'Desktop1' = @{
            
        }

        'Desktop2' = @{
            'Pin0' = "$($env:LOCALAPPDATA)\Programs\Microsoft VS Code\_\Code.exe"
            #'Pin0' = "%LocalAppData%\Programs\Microsoft VS Code\_\Code.exe"
            'Pin1' = "C:\Program Files (x86)\Royal TS V5\RoyalTS.exe"
            'Pin2' = "C:\Program Files\Oracle\VirtualBox\VirtualBox.exe"
            'Pin3' = "C:\Program Files\WindowsApps\CanonicalGroupLimited.UbuntuonWindows_2004.2020.812.0_x64__79rhkp1fndgsc\ubuntu.exe"
            'Pin4' = "C:\Program Files\Git\cmd\git-gui.exe"
            'Pin5' = "F:\Creations\Software Projects\Development\Powershell scripts\vdtm\AdvancedShortcuts\PowerShell.exe"

        }
        'Desktop3' = @{
            'Pin0' = "C:\Program Files\REAPER (x64)\reaper.exe"
            'Pin1' = "C:\Program Files (x86)\Line6\HX Edit\HX Edit.exe"
            'Pin2' = "C:\Program Files\Audionamix\XTRAX STEMS\XTRAX STEMS.exe"
            'Pin3' = "C:\Program Files (x86)\VB\Voicemeeter\voicemeeter8.exe"
            'Pin4' = "C:\Program Files\FocusriteUSB\smc\Scarlett MixControl.exe"
        }
        'Desktop4' = @{
            'Pin0' = "C:\Program Files (x86)\Blackmagic Design\DaVinci Resolve Panels\DaVinci Resolve Panels Setup.exe"
        }

        'Desktop5' = @{
            'Pin0' = "C:\Program Files\Capture One\Capture One 20\CaptureOne.exe"
            'Pin1' = "C:\Program Files (x86)\FUJIFILM\XAcquire\XAcquire.exe"
            'Pin2' = "C:\ProgramData\Microsoft\Windows\Start Menu\FUJIFILM X Webcam 2.lnk"
        }

        'Desktop6' = @{
            'Pin0' = "C:\Program Files (x86)\Steam\steamapps\common\rocketleague\Binaries\Win32\RocketLeague.exe"
            'Pin1' = "C:\Program Files (x86)\Steam\steam.exe"
            #'Pin2' = "$($env:LOCALAPPDATA)\Discord\Update.exe --processStart Discord.exe"
            'Pin2' = "%LocalAppData%\Discord\Update.exe --processStart Discord.exe"
        }
    }
}

