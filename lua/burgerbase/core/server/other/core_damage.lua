function BURGERBASE_HOOK_ScalePlayerDamage(ply, hitgroup, dmginfo)

	local Inflictor = dmginfo:GetInflictor()
	
	if Inflictor ~= NULL and Inflictor ~= nil then
		if Inflictor:IsPlayer() then
			Weapon = Inflictor:GetActiveWeapon()
		end
	end

	if Weapon ~= NULL and Weapon ~= nil then
		if Weapon.FatalHeadshot and hitgroup == HITGROUP_HEAD then
			local Damage = math.max(dmginfo:GetDamage(),ply:Health())
			dmginfo:SetDamage(Damage)
		end
	end

	if BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_damage_enable",false):GetBool() then
	
		if BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_damage_sandboxfix",false):GetBool() then
			if ( hitgroup == HITGROUP_HEAD ) then
				dmginfo:ScaleDamage( 0.5 )
			elseif ( hitgroup == HITGROUP_LEFTARM || hitgroup == HITGROUP_RIGHTARM || hitgroup == HITGROUP_LEFTLEG || hitgroup == HITGROUP_RIGHTLEG || hitgroup == HITGROUP_GEAR ) then
				dmginfo:ScaleDamage( 4 )
			end
		end
		
		if hitgroup == HITGROUP_LEFTLEG || hitgroup == HITGROUP_RIGHTLEG then
			dmginfo:ScaleDamage( BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_damage_legscale",false):GetFloat() )
		elseif hitgroup == HITGROUP_LEFTARM || hitgroup == HITGROUP_RIGHTARM then
			dmginfo:ScaleDamage( BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_damage_armscale",false):GetFloat() )
		elseif hitgroup == HITGROUP_HEAD then
			dmginfo:ScaleDamage( BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_damage_headscale",false):GetFloat() )
		else
			dmginfo:ScaleDamage( BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_damage_bodyscale",false):GetFloat() )
		end
		
	end
	
end

hook.Add("ScalePlayerDamage","BURGERBASE_HOOK_ScalePlayerDamage",BURGERBASE_HOOK_ScalePlayerDamage)
hook.Add("ScaleNPCDamage","BURGERBASE_HOOK_ScalePlayerDamage",BURGERBASE_HOOK_ScalePlayerDamage)

