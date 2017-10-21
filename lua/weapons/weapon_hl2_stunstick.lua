if CLIENT then
	killicon.AddFont( "weapon_hl2_stunstick",	"HL2MPTypeDeath",	"!",	Color( 255, 80, 0, 255 ) )
end

SWEP.Category				= "BurgerBase: Half Life 2"
SWEP.PrintName				= "Stunstick"
SWEP.Base					= "weapon_burger_core_base"
SWEP.WeaponType				= "Melee"

SWEP.Cost					= 0
SWEP.CSSMoveSpeed			= 240

SWEP.Spawnable				= true
SWEP.AdminOnly				= false

SWEP.Slot					= 0
SWEP.SlotPos				= 1

SWEP.ViewModel 				= "models/weapons/c_stunstick.mdl"
SWEP.WorldModel				= "models/weapons/w_stunbaton.mdl"
SWEP.VModelFlip 			= false
SWEP.HoldType				= "melee"

game.AddAmmoType({name = "smod_metal"})

if CLIENT then 
	language.Add("smod_metal_ammo","Metal")
end

SWEP.Primary.Damage			= 55
SWEP.Primary.NumShots		= 1
SWEP.Primary.ClipSize		= 100
SWEP.Primary.SpareClip		= 0
SWEP.Primary.Delay			= 0.6
SWEP.Primary.Ammo			= "smod_metal"
SWEP.Primary.Automatic 		= true 

SWEP.Secondary.Damage		= 0
SWEP.Secondary.NumShots		= 1
SWEP.Secondary.ClipSize		= -1
SWEP.Secondary.SpareClip	= -1
SWEP.Secondary.Delay		= 1
SWEP.Secondary.Ammo			= "none"
SWEP.Secondary.Automatic 	= false 

SWEP.RecoilMul				= 1
SWEP.HasScope 				= false
SWEP.ZoomAmount 			= 1
SWEP.HasCrosshair 			= false
SWEP.HasCSSZoom 			= false

SWEP.HasPumpAction 			= false
SWEP.HasBoltAction 			= false
SWEP.HasBurstFire 			= false
SWEP.HasSilencer 			= false
SWEP.HasDoubleZoom			= false
SWEP.HasSideRecoil			= false

SWEP.MeleeSoundMiss			= Sound("Weapon_StunStick.Melee_Miss")
SWEP.MeleeSoundWallHit		= Sound("Weapon_StunStick.Melee_HitWorld")
SWEP.MeleeSoundFleshSmall	= Sound("Weapon_StunStick.Melee_Hit")
SWEP.MeleeSoundFleshLarge	= Sound("Weapon_StunStick.Melee_Hit")

SWEP.IronSightTime			= 0.125
SWEP.IronSightsPos 			= Vector(-10, -10, 5)
SWEP.IronSightsAng 			= Vector(0, 0, -45)

SWEP.AddFOV					= 10


SWEP.EnableBlocking			= true

SWEP.DamageFalloff			= 40
SWEP.MeleeDamageType		= DMG_SHOCK
SWEP.MeleeDelay				= 0

SWEP.MeleeBlockReduction 	= 0.25

SWEP.HasDurability 			= true
SWEP.DurabilityPerHit 		= -5

SWEP.MeleeBlockReduction 	= 0.40

function SWEP:MeleeRange()
	return 40
end

function SWEP:MeleeSize()
	return 24
end

function SWEP:PrimaryAttack()

	if self:IsUsing() then return end
	if self:GetNextPrimaryFire() > CurTime() then return end
	if self.Owner:KeyDown(IN_ATTACK2) then return end
	
	self.Owner:SetAnimation(PLAYER_ATTACK1)

	local Delay = self.Primary.Delay
	local Damage = self.Primary.Damage*0.75 + (self.Primary.Damage*0.25*self:Clip1()*0.01)
	local Victim = self:StartSwing(Damage)
	
	if Victim and Victim ~= NULL then
		self:SendWeaponAnim(ACT_VM_HITCENTER)
	else
		self:SendWeaponAnim(ACT_VM_MISSCENTER)
		Delay = Delay*1.25
	end
	
	self:SetNextPrimaryFire(CurTime() + Delay)
	self:SetNextSecondaryFire(CurTime() + Delay)

end




function SWEP:SpareThink()
	if self.Owner:KeyDown(IN_ATTACK2) then
		self.CSSMoveSpeed				= 240*0.25
	else
		self.CSSMoveSpeed				= 240
	end
end


function SWEP:SecondaryAttack()

end

function SWEP:Reload()
	--PrintTable(GetActivities(self))
end




