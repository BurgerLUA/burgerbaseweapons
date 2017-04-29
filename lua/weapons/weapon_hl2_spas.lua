if CLIENT then
	killicon.AddFont( "weapon_hl2_spas",		"HL2MPTypeDeath",	"0",	Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/m3")
end

SWEP.Category				= "Extra Weapons"
SWEP.PrintName				= "Shotgun"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Cost					= 0
SWEP.CSSMoveSpeed			= 230

SWEP.Slot					= 2
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/c_shotgun.mdl"
SWEP.WorldModel				= "models/weapons/w_shotgun.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= (56*3) / 7
SWEP.Primary.NumShots		= 7
SWEP.Primary.Sound			= Sound("weapons/shotgun/shotgun_fire7.wav")
SWEP.Primary.Cone			= 0.05
SWEP.Primary.ClipSize		= 6
SWEP.Primary.SpareClip		= 30
SWEP.Primary.Delay			= 0.3
SWEP.Primary.Ammo			= "Buckshot"
SWEP.Primary.Automatic 		= true

SWEP.ReloadSound = Sound("weapons/shotgun/shotgun_reload3.wav")
SWEP.BurstSound = Sound("weapons/shotgun/shotgun_dbl_fire.wav")

SWEP.RecoilMul				= 0.5
SWEP.SideRecoilMul			= 0.5
SWEP.RecoilSpeedMul			= 0.75
SWEP.MoveConeMul			= 1
SWEP.HeatMul				= 0.5
SWEP.CoolMul				= 1
SWEP.CoolSpeedMul			= 1

SWEP.BurstOverride			= 2
SWEP.BurstSpeedOverride 	= 0.1
SWEP.BurstHeatMul			= 1.5

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 0.25
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= true
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire			= true
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= true
SWEP.HasFirstShotAccurate	= false

SWEP.DamageFalloff			= 200
SWEP.Primary.Range			= 400
SWEP.HasHL2Pump				= true
SWEP.PumpSound				= Sound("weapons/shotgun/shotgun_cock.wav")
SWEP.PenetrationLossScale	= 0.5
SWEP.CanShootWhileSprinting = false

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.25

SWEP.IronSightsPos 			= Vector(-8.24, 0, 1.72)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.IronRunPos = Vector(0, 0, 0)
SWEP.IronRunAng = Vector(0, 26.03, 0)

SWEP.IronMeleePos = Vector(0, -7.035, -3.619)
SWEP.IronMeleeAng = Vector(-2.814, 42.21, -42.211)
