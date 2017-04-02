if CLIENT then
	killicon.AddFont( "weapon_burger_cs_m3", "csd", "k", Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/m3")
end

SWEP.Category				= "Counter-Strike"
SWEP.PrintName				= "M3SUPER90"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Cost					= 1700
SWEP.CSSMoveSpeed				= 220

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 2
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/cstrike/c_shot_m3super90.mdl"
SWEP.WorldModel				= "models/weapons/w_shot_m3super90.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "ar2"

SWEP.Primary.Damage			= 26*0.8
SWEP.Primary.NumShots		= 9
SWEP.Primary.Sound			= Sound("Weapon_M3.Single")
SWEP.Primary.Cone			= 0.04
SWEP.Primary.ClipSize		= 8
SWEP.Primary.SpareClip		= 32
SWEP.Primary.Delay			= 0.88 --1/(68/60)
SWEP.Primary.Ammo			= "bb_12gauge"
SWEP.Primary.Automatic 		= false

SWEP.RecoilMul				= 0.05
SWEP.SideRecoilMul			= 0.25
SWEP.MoveConeMul				= 1
SWEP.HeatMul				= 2
SWEP.CoolMul				= 0.75

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 0.25
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= true
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= false

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.125
SWEP.IronSightsPos 			= Vector(-6, 0, 1.5)
SWEP.IronSightsAng 			= Vector(0, 0, 0)

SWEP.DamageFalloff			= 300

SWEP.PenetrationLossScale	= 0.5

SWEP.SpecialAmmo			= {"bb_12gauge","bb_12gaugeslug"}

function SWEP:SpecialGiveAmmo()
	self.Owner:GiveAmmo(12,"bb_12gaugeslug",false)
end

function SWEP:SpecialShots(shots)
	if self:GetPrimaryAmmo() == game.GetAmmoID("bb_12gaugeslug") then
		shots = 1
	end
	return shots
end

function SWEP:SpecialDamage(damage)
	if self:GetPrimaryAmmo() == game.GetAmmoID("bb_12gaugeslug") then
		damage = 90
	end
	return damage
end

function SWEP:SpecialFalloff(falloff)
	if self:GetPrimaryAmmo() == game.GetAmmoID("bb_12gaugeslug") then
		falloff = 1000
	end
	return falloff
end

function SWEP:SpecialRecoil(recoil)
	if self:GetPrimaryAmmo() == game.GetAmmoID("bb_12gaugeslug") then
		recoil = recoil * 2
	end
	return recoil
end

function SWEP:SpecialConePre(cone)
	if self:GetPrimaryAmmo() == game.GetAmmoID("bb_12gaugeslug") then
		cone = cone*0.25
	end
	return cone
end



