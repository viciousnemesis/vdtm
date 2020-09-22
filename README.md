# Virtual Desktop Taskbar Manager
Working in conjunction with Dexpot virtual desktop manager, this script controls which applications are pinned to the taskbar for a given desktop. Microsoft has made this difficult (near impossible), and so Dexpot does not manage the tasbar. However, there are a few ways to do this, and I explore them here. 

The general process involves reading from Dexpot's log, parsing through it to determine when a desktop has switched, and then running the necessary code.

The first iteration was using another application called Syspin, but I found it slow, and a bit more error prone than I wanted.

The current iteration is clunky, but less error prone, and does away with Syspin. Instead, it uses Microsoft's \%AppData%\Local\Microsoft\Windows\Shell\LayoutModification.xml file. The problem with this approach, is that it only gets loaded once, when explorer.exe launches (booting, logging in, etc.). So, this script restarts explorer.exe, and so you get a bit of a weird flash. But it works faster than the first solution, and I haven't noticed any issues with how it's working.



**Things to do next, if they're possible ;)**

1. Windows kills File Explorer windows when explorer.exe is restarted, and doesn't restore them. The goal would be to keep track of what file explorer windows are open, and on which desktop, and use this to restore as desktops are switch. 

1. It would be nice to figure out how to do this without needing the log file, and continuously reading from it. 



**What it looks like**
![](demo.gif)
