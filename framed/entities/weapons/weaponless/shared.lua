//General Settings \\ 
SWEP.PrintName 		= "hands" // The name of your SWEP 
 
SWEP.Author 		= "JustPlayerDE" // Your name 
SWEP.Instructions 	= "Use it to hide your weapons" // How do people use your SWEP? 
SWEP.Contact 		= "" // How people should contact you if they find bugs, errors, etc 
SWEP.Purpose 		= "Hide Weapons from Cops" // What is the purpose of the SWEP? 
 
SWEP.AdminSpawnable = true // Is the SWEP spawnable for admins? 
SWEP.Spawnable 		= false // Can everybody spawn this SWEP? - If you want only admins to spawn it, keep this false and admin spawnable true. 
 
SWEP.ViewModelFOV 	= 64 // How much of the weapon do you see? 
SWEP.ViewModel 		= "" // The viewModel = the model you see when you're holding the weapon.
SWEP.WorldModel 	= "" // The world model = the model you when it's down on the ground.
 
SWEP.AutoSwitchTo 	= true // When someone picks up the SWEP, should it automatically change to your SWEP? 
SWEP.AutoSwitchFrom = true // Should the weapon change to the a different SWEP if another SWEP is picked up?
 
SWEP.Slot 			= 0 // Which weapon slot you want your SWEP to be in? (1 2 3 4 5 6) 
SWEP.SlotPos = 1 // Which part of that slot do you want the SWEP to be in? (1 2 3 4 5 6) 
 
SWEP.HoldType = "normal" // How is the SWEP held? (Pistol SMG Grenade Melee) 
 
SWEP.FiresUnderwater = false // Does your SWEP fire under water?
 
SWEP.Weight = 5 // Set the weight of your SWEP. 
 
SWEP.DrawCrosshair = false // Do you want the SWEP to have a crosshair? 
 
SWEP.Category = "FRAMED" // Which weapon spawning category do you want your SWEP to be in?
 
SWEP.DrawAmmo = false // Does the ammo show up when you are using it? True / False 
 
SWEP.ReloadSound = "" // Reload sound, you can use the default ones, or you can use your own; Example; "sound/myswepreload.wav" 
 
SWEP.base = "weapon_base" //What your weapon is based on.
//General settings\\
 
//PrimaryFire Settings\\ 
SWEP.Primary.Sound = "" // The sound that plays when you shoot your SWEP :-] 
SWEP.Primary.Damage = 0 // How much damage the SWEP will do.
SWEP.Primary.TakeAmmo = 0 // How much ammo does the SWEP use each time you shoot?
SWEP.Primary.ClipSize = 0 // The clip size.
SWEP.Primary.Ammo = "" // The ammo used by the SWEP. (pistol/smg1) 
SWEP.Primary.DefaultClip = 0 // How much ammo do you get when you first pick up the SWEP? 
SWEP.Primary.Spread = 0 // Do the bullets spread all over when firing? If you want it to shoot exactly where you are aiming, leave it at 0.1 
SWEP.Primary.NumberofShots = 0 // How many bullets the SWEP fires each time you shoot. 
SWEP.Primary.Automatic = false // Is the SWEP automatic?
SWEP.Primary.Recoil = 0 // How much recoil does the weapon have?
SWEP.Primary.Delay = 0 // How long must you wait before you can fire again?
SWEP.Primary.Force = 0 // The force of the shot.
//PrimaryFire settings\\
 
//Secondary Fire Variables\\ 
SWEP.Secondary.NumberofShots = 0 // How many explosions for each shot.
SWEP.Secondary.Force = 0 // The force of the explosion.
SWEP.Secondary.Spread = 0 // How much of an area does the explosion affect? 
SWEP.Secondary.Sound = "" // The sound that is made when you shoot.
SWEP.Secondary.DefaultClip = 0 // How much secondary ammo does the SWEP come with?
SWEP.Secondary.Automatic = false // Is it automactic? 
SWEP.Secondary.Ammo = "" // Leave as Pistol! 
SWEP.Secondary.Recoil = 0 // How much recoil does the secondary fire have?
SWEP.Secondary.Delay = 0 // How long you have to wait before firing another shot?
SWEP.Secondary.TakeAmmo = 0 // How much ammo does each shot take?
SWEP.Secondary.ClipSize = 0 // The size of the clip for the secondary ammo.
SWEP.Secondary.Damage = 0 // The damage the explosion does. 
SWEP.Secondary.Magnitude = "0" // How big is the explosion ? 
SWEP.BlockedUntil = 0
//Secondary Fire Variables\\
 
//SWEP:Initialize\\ 
function SWEP:Initialize() //Tells the script what to do when the player "Initializes" the SWEP.
	util.PrecacheSound(self.Primary.Sound) 
	util.PrecacheSound(self.Secondary.Sound) 
        self:SetWeaponHoldType( self.HoldType )
end 
//SWEP:Initialize\\
 
//SWEP:PrimaryFire\\ 
function SWEP:PrimaryAttack()
 
end 
//SWEP:PrimaryFire\\
 
//SWEP:SecondaryFire\\ 
function SWEP:SecondaryAttack() 

end 
//SWEP:SecondaryFire\\

