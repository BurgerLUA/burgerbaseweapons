if CLIENT then
	killicon.AddFont( "weapon_burger_cs_ak47", "csd", "b", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/ak47")
end

SWEP.Category				= "Counter-Strike"
SWEP.PrintName				= "AK-47"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 2500
SWEP.CSSMoveSpeed			= 221

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 3
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_rif_ak47.mdl"
SWEP.WorldModel				= "models/weapons/w_rif_ak47.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 36
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("Weapon_AK47.Single")
SWEP.Primary.Cone			= 0.0025
SWEP.Primary.ClipSize		= 30
SWEP.Primary.SpareClip		= 90
SWEP.Primary.Delay			= 0.1
SWEP.Primary.Ammo			= "bb_762mm"
SWEP.Primary.Automatic 		= true

SWEP.RecoilMul				= 1
SWEP.SideRecoilMul			= 0.5
SWEP.MoveConeMul				= 1.5
SWEP.HeatMul				= 1.5
SWEP.CoolMul				= 0.6

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 1
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false 
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= true

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.125
SWEP.IronSightsPos 			= Vector(-6, 10, 0)
SWEP.IronSightsAng 			= Vector(2, 0, 0)

SWEP.DamageFalloff			= 4000