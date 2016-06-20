If Not FileExists($DataFolder) Then DirCreate($DataFolder)
FileInstall("vcredist_x86.exe","vcredist_x86.exe")
FileInstall("dotNetFx4.exe","dotNetFx4.exe")