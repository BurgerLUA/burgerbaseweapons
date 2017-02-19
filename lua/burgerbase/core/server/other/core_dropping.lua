local AssociatedWeapons = {
	bb_hegrenade = "weapon_burger_cs_he",
	bb_flashgrenade = "weapon_burger_cs_flash",
	bb_smokegrenade = "weapon_burger_cs_smoke",
	ex_gasgrenade = "weapon_burger_ex_gas"
}

local function BURGERBASE_HOOK_DoPlayerDeath(ply)

	ply:SetNWString("cssprimary","")
	ply:SetNWString("csssecondary","")

	if BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_drops_enable",false):GetInt() == 1 then
	
		for k,v in pairs(ply:GetWeapons()) do
			BURGERBASE_FUNC_DropWeapon(ply,v)
		end
		
		BURGERBASE_FUNC_DropAmmo(ply,"all")
		
	end
end
	
hook.Add("DoPlayerDeath", "BURGERBASE_HOOK_DoPlayerDeath", BURGERBASE_HOOK_DoPlayerDeath )

local NextThink = 0

local function BURGERBASE_HOOK_Think()
	if NextThink <= CurTime() then
		for k,v in pairs(player.GetAll()) do
			for ammo,weapon in pairs(AssociatedWeapons) do
				if not v:HasWeapon(weapon) then
					if v:GetAmmoCount(ammo) > 0 then
						local NewWeapon = v:Give(weapon)
						NewWeapon.AlreadyGiven = true
					end
				end
			end
		end
		NextThink = CurTime() + 1
	end
end

hook.Add("Think","BURGERBASE_HOOK_Think",BURGERBASE_HOOK_Think)

function BURGERBASE_FUNC_DropWeapon(ply,weapon)

	if weapon:IsScripted() == true then
		if weapon.BurgerBase ~= nil or weapon.Base == "weapon_burger_core_base" then
		
			local StoredWeapon =  weapons.GetStored(weapon:GetClass())
			
			if weapon.EnableDropping then
			
				local model = StoredWeapon.WorldModel
				
				if StoredWeapon.DisplayModel then
					model = StoredWeapon.DisplayModel
				end
				
				local Ammo = weapon:Ammo1()

				if model ~= "" then		

					local dropped = ents.Create("ent_burger_core_dropped_weapon")
					dropped:SetPos(ply:GetPos() + ply:OBBCenter())
					dropped:SetAngles(ply:EyeAngles())
					dropped:SetModel(model)
					dropped:SetNWString("class",weapon:GetClass())
					dropped:SetCustomCollisionCheck( true )
				
					if not (StoredWeapon.WeaponType == "Throwable" and weapon:Clip1() ~= 0) then
						
						dropped:SetNWFloat("clip",weapon:Clip1())
						
						if ply:Alive() then
							ply:StripWeapon(weapon:GetClass())
						end
						
					elseif StoredWeapon.WeaponType == "Throwable" then
						
						if Ammo < 10 then
						
							dropped:SetNWFloat("clip",weapon:Clip1())
							
							if ply:Alive() then
							
								ply:SetAmmo( math.Clamp(Ammo - 1,0,9999), weapon:GetPrimaryAmmoType() )
								
								Ammo = weapon:Ammo1()
								
								if Ammo == 0 then
									ply:StripWeapon(weapon:GetClass())
								end
								
							end
							
						else
						
							BURGERBASE_FUNC_DropAmmo(ply,weapon,Ammo)
							
							if ply:Alive() then
								ply:StripWeapon(weapon:GetClass())
							end
						
							dropped:Remove()
						
							return
							
						end
					
					end

					dropped:Spawn()
					dropped:Activate()
					dropped:GetPhysicsObject():SetVelocity(ply:EyeAngles():Forward()*100)

				end
			
			end
			
		end
	end
	
end

function BURGERBASE_FUNC_DropAmmo(ply,weapon,amount)

	if weapon == "all" then
		local AllAmmoTable = {}
		
		for i = 1, 100 do
			AllAmmoTable[i] = ply:GetAmmoCount( i )
		end
		
		if AllAmmoTable[1] then
		
			local dropammo = ents.Create("ent_burger_core_dropped_ammo")
			dropammo.AmmoTable = AllAmmoTable
			dropammo.AmmoModel = "models/weapons/w_defuser.mdl"
			dropammo:SetPos( ply:GetPos() + ply:OBBCenter() )
			dropammo:SetAngles(ply:EyeAngles() + Angle( math.Rand(1,360),math.Rand(1,360),math.Rand(1,360)) )
			dropammo:SetCustomCollisionCheck( true )
			dropammo:Spawn()
			dropammo:Activate()
			dropammo:GetPhysicsObject():SetVelocity(ply:GetForward()*100)

			if BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_drops_timed",false):GetInt() == 1 then
				SafeRemoveEntityDelayed(dropammo,BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_drops_timer",false):GetInt())
			end
			
		end
	else
	
		local model = "models/weapons/w_defuser.mdl"
	
		if weapon:IsScripted() and (weapon.BurgerBase or weapon.Base == "weapon_burger_core_base") then
			if weapon.WeaponType == "Throwable" and weapon.Primary.ClipSize == -1 then
				model = weapon.WorldModel
			elseif weapon.GetMagModel then
				if file.Exists(weapon.GetMagModel,"GAME") then
					model = weapon.GetMagModel
				end
			end
		end
		
		local AmmoType = weapon:GetPrimaryAmmoType()
		local AmmoCount = ply:GetAmmoCount(AmmoType)
		local ClipCount = weapon:GetMaxClip1()
		
		if ClipCount == -1 and weapon.Primary.SpareClip then
			ClipCount = math.Clamp(math.ceil(weapon.Primary.SpareClip * 0.1),-1,9999)
		end

		local AmmoCountToDrop = math.min(AmmoCount,ClipCount)
		
		if amount then
			AmmoCountToDrop = amount
		end
		
		if ply:Alive() then
			ply:SetAmmo( math.Clamp(AmmoCount - AmmoCountToDrop,0,9999) , AmmoType)
		end
		
		if AmmoCountToDrop > 0 then
		
			local dropammo = ents.Create("ent_burger_core_ammo")
			dropammo.AmmoType = weapon:GetPrimaryAmmoType()
			dropammo.AmmoAmount = AmmoCountToDrop
			dropammo.AmmoModel = model
			dropammo:SetPos( ply:GetPos() + ply:OBBCenter() )
			dropammo:SetAngles(ply:EyeAngles() + Angle( math.Rand(1,360),math.Rand(1,360),math.Rand(1,360)) )
			dropammo:Spawn()
			dropammo:Activate()
			dropammo:GetPhysicsObject():SetVelocity(ply:GetForward()*100)
			
			if weapon.WeaponType == "Throwable" then
				if ply:GetAmmoCount(AmmoType) <= 0 then
					ply:StripWeapon(weapon:GetClass())
				end
			end
	
		end
			
	end

end

local function BURGERBASE_COMMAND_Dropping(ply,cmd,args,argStr)

	local Weapon = ply:GetActiveWeapon()
	
	if Weapon and Weapon:IsValid() then
		if cmd == "dropweapon" then
			BURGERBASE_FUNC_DropWeapon(ply,Weapon)
		elseif cmd == "dropammo" then
			BURGERBASE_FUNC_DropAmmo(ply,Weapon)
		end
	end

end

concommand.Add("dropweapon", BURGERBASE_COMMAND_Dropping)
concommand.Add("dropammo", BURGERBASE_COMMAND_Dropping)
