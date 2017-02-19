
function BURGERBASE_HOOK_ScalePlayerDamage(ply, hitgroup, dmginfo)

	local DamageScale,DamageOverride = BURGERBASE_FUNC_GetDamageScale(ply,hitgroup,dmginfo)
	
	if not DamageScale then
		dmginfo:SetDamage(DamageOverride)
	else
		dmginfo:ScaleDamage(DamageScale)
	end

end

function BURGERBASE_FUNC_GetDamageScale(ply,hitgroup,dmginfo)

	local Inflictor = dmginfo:GetInflictor()
	
	local DamageScale = 1
	local Damage = nil
	
	if Inflictor ~= NULL and Inflictor ~= nil then
		if Inflictor:IsPlayer() then
			Weapon = Inflictor:GetActiveWeapon()
		end
	end

	if Weapon ~= NULL and Weapon ~= nil then
		if Weapon.FatalHeadshot and hitgroup == HITGROUP_HEAD then
			local Damage = math.max(dmginfo:GetDamage(),ply:Health())
			return nil,Damage
		end
	end

	if BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_damage_enable",false):GetBool() then
	
		if BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_damage_sandboxfix",false):GetBool() then
			if ( hitgroup == HITGROUP_HEAD ) then
				DamageScale = DamageScale*0.5
			elseif ( hitgroup == HITGROUP_LEFTARM || hitgroup == HITGROUP_RIGHTARM || hitgroup == HITGROUP_LEFTLEG || hitgroup == HITGROUP_RIGHTLEG || hitgroup == HITGROUP_GEAR ) then
				DamageScale = DamageScale*4
			end
		end
		
		if hitgroup == HITGROUP_LEFTLEG || hitgroup == HITGROUP_RIGHTLEG then
			DamageScale = DamageScale * BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_damage_legscale",false):GetFloat()
		elseif hitgroup == HITGROUP_LEFTARM || hitgroup == HITGROUP_RIGHTARM then
			DamageScale = DamageScale * BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_damage_armscale",false):GetFloat()
		elseif hitgroup == HITGROUP_HEAD then
			DamageScale = DamageScale * BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_damage_headscale",false):GetFloat()
		else
			DamageScale = DamageScale * BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_damage_bodyscale",false):GetFloat()
		end
		
	end
	
	return DamageScale,Damage

end



hook.Add("ScalePlayerDamage","BURGERBASE_HOOK_ScalePlayerDamage",BURGERBASE_HOOK_ScalePlayerDamage)
hook.Add("ScaleNPCDamage","BURGERBASE_HOOK_ScalePlayerDamage",BURGERBASE_HOOK_ScalePlayerDamage)

