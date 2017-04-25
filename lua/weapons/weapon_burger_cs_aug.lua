if CLIENT then
	killicon.AddFont( "weapon_burger_cs_aug", "csd", "e", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon		= surface.GetTextureID("vgui/gfx/vgui/aug")
end 

SWEP.Category				= "Counter-Strike"
SWEP.PrintName				= "AUG"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 3500
SWEP.CSSMoveSpeed				= 221

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_rif_aug.mdl"
SWEP.WorldModel				= "models/weapons/w_rif_aug.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "smg"

SWEP.Primary.Damage			= 32
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_AUG.Single")
SWEP.Primary.Cone			= 0.001
SWEP.Primary.ClipSize		= 30
SWEP.Primary.SpareClip		= 90
SWEP.Primary.Delay			= 0.09
SWEP.Primary.Ammo			= "bb_556mm"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.5
SWEP.RecoilSpeedMul			= 0.9
SWEP.MoveConeMul			= 2
SWEP.HeatMul				= 0.25
SWEP.CoolMul				= 0.75
SWEP.CoolSpeedMul			= 1
SWEP.MaxHeat				= 10

SWEP.HasScope 				= true
SWEP.ZoomAmount				= 3
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= true

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= false
SWEP.HasFirstShotAccurate	= true

SWEP.HasIronSights 			= false
SWEP.EnableIronCross		= false
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.5
SWEP.ZoomTime				= 0.5
SWEP.IronSightsPos 			= Vector(-7, -5, 2)
SWEP.IronSightsAng 			= Vector(0, 0, -30)

SWEP.DamageFalloff			= 3000

SWEP.ZoomDelay				= 0.125

SWEP.CanShootWhileSprinting = false
SWEP.IronRunPos				= Vector(0,-10,1)
SWEP.IronRunAng				= Vector(-10,30,0)