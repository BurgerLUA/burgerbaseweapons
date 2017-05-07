if CLIENT then
	killicon.AddFont( "weapon_hl2_smg",		"HL2MPTypeDeath",	"/",	Color( 255, 80, 0, 255 ) )
	SWEP.WepSelectIcon 		= surface.GetTextureID("vgui/gfx/vgui/mp5")
end

SWEP.Category				= "BurgerBase: Half Life 2"
SWEP.PrintName				= "SMG1"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Primary"

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Cost					= 0
SWEP.CSSMoveSpeed			= 230


SWEP.Slot					= 2
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/c_smg1.mdl"
SWEP.WorldModel				= "models/weapons/w_smg1.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "smg"

SWEP.Primary.Damage			= 20
SWEP.Primary.NumShots		= 1
SWEP.Primary.Sound			= Sound("weapons/smg1/smg1_fire1.wav")
SWEP.Primary.Cone			= .0025
SWEP.Primary.ClipSize		= 45
SWEP.Primary.SpareClip		= 120
SWEP.Primary.Delay			= 1/(750/60)
SWEP.Primary.Ammo			= "smg1"
SWEP.Primary.Automatic 		= true
SWEP.ReloadSound			= Sound("weapons/smg1/smg1_reload.wav")
--SWEP.BurstSound				= Sound("weapons/smg1/smg1_fireburst1.wav")

SWEP.RecoilMul				= 2
SWEP.SideRecoilMul			= 0.25
SWEP.RecoilSpeedMul			= 1.5
SWEP.MoveConeMul			= 1
SWEP.HeatMul				= 0.5
SWEP.CoolMul				= 1
SWEP.CoolSpeedMul			= 1

SWEP.BurstConeMul			= 0.5
SWEP.BurstRecoilMul			= 0.5

SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 0.25
SWEP.HasCrosshair 			= true
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= true
SWEP.HasDownRecoil			= false
SWEP.HasDryFire				= false
SWEP.HasSpecialFire 		= true
SWEP.HasFirstShotAccurate	= true
SWEP.CanShootWhileSprinting = true

SWEP.DamageFalloff			= 1000

SWEP.Object					= "grenade_ar2"

SWEP.HasIronSights 			= true
SWEP.EnableIronCross		= true
SWEP.HasGoodSights			= true
SWEP.IronSightTime			= 0.25

SWEP.IronSightsPos = Vector(-6.4, 0, 1.039)
SWEP.IronSightsAng = Vector(0, 0, 0)

SWEP.IronRunPos				= Vector(0,0,0)
SWEP.IronRunAng				= Vector(0,0,0)

SWEP.IronMeleePos = Vector(0, 0, 0)
SWEP.IronMeleeAng = Vector(-9.146, 30.25, -37.991)

function SWEP:ReloadSpecial()

	if not self:CanPrimaryAttack() then	return end
	if self:IsBusy() then return end
	if self:GetNextPrimaryFire() > CurTime() then return end
	
	if self:Clip1() < 15 then return end
	self:TakePrimaryAmmo(15)
	self.Owner:SetAnimation(PLAYER_ATTACK1)
	self:WeaponAnimation(self:Clip1(),ACT_VM_SECONDARYATTACK)

	if (IsFirstTimePredicted() or game.SinglePlayer()) then
		if (CLIENT or game.SinglePlayer()) then 
			self:AddRecoil() -- Predict
		end

		self:ThrowObject(self.Object,1000)
		
		self:EmitGunSound("weapons/ar2/ar2_altfire.wav")
	end
	
	self:SetNextPrimaryFire(CurTime() + self.Primary.Delay*10*2)
	
end
