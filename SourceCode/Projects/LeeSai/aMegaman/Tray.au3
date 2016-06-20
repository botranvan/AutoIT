Opt("TrayOnEventMode", 1)
Opt("TrayMenuMode", 1+8+2)

Global $TrayOnTop = TrayCreateItem("Not On-Top")
TrayItemSetOnEvent($TrayOnTop,"FCharSetOnTop")

Global $TrayReborn = TrayCreateItem("Reborn")
TrayItemSetOnEvent($TrayReborn,"FCharReborn")

Global $TrayHelp = TrayCreateItem("Help")
TrayItemSetOnEvent($TrayHelp,"FAutoHelp")

TrayCreateItem("")

Global $TrayExit = TrayCreateItem("Exit")
TrayItemSetOnEvent($TrayExit,"FAutoEnd")

TraySetState()
