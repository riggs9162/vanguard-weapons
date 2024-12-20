MODULE = {}

MODULE.Name = "Weapons"
MODULE.Description = "A base module for creating simple weapons, very similar to the Longsword Weapon Base."
MODULE.Author = "Riggs"
MODULE.Version = "0.5.0"
MODULE.VersionLink = "https://raw.githubusercontent.com/Minerva-Servers/vwep/refs/heads/main/VERSION.txt"

vanguard.util:Include("sh_commands.lua")
vanguard.util:Include("sh_firemodes.lua")
vanguard.util:Include("sh_util.lua")

vanguard.modules:Register(MODULE)