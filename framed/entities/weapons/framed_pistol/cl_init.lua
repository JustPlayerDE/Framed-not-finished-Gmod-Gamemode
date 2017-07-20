include('shared.lua')

SWEP.PrintName	= "FRAMED PISTOL"	// 'Nice' Weapon name (Shown on HUD)	
SWEP.Slot	= 1	// Slot in the weapon selection menu
SWEP.SlotPos	= 1	// Position in the slot

// Override this in your SWEP to set the icon in the weapon selection
if (file.Exists("../materials/weapons/weapon_pistol.vmt", "GAME")) then
SWEP.WepSelectIcon	= surface.GetTextureID("weapons/weapon_pistol")
end
