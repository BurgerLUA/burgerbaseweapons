function BURGERBASE_HOOK_Move(ply,mv)

	if BURGERBASE and BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_speedmod",false):GetBool() then
		
		local ActiveWeapon = ply:GetActiveWeapon()
		
		local BaseSpeed = 250
		local WeaponSpeed = 250
		
		if ActiveWeapon and ActiveWeapon ~= NULL and ActiveWeapon.CSSMoveSpeed then
			WeaponSpeed = ActiveWeapon.CSSMoveSpeed
		end

		if WeaponSpeed ~= -1 then
			local PreviousLimit = mv:GetMaxClientSpeed()
			local SpeedMod = (WeaponSpeed / BaseSpeed)
			local NewLimit = PreviousLimit * SpeedMod
			
			if SERVER then
				--print(math.Round(CurTime(),2),"CSS:",PreviousLimit,NewLimit)
			end
			
			mv:SetMaxSpeed( NewLimit )
			mv:SetMaxClientSpeed( NewLimit )
		end

	end

end

hook.Add("Move","BURGERBASE_HOOK_Move",BURGERBASE_HOOK_Move)

function BURGERBASE_HOOK_PlayerSwitchWeapon(ply,oldweapon,newweapon)

	--print("BOOP")

	--if not IsFirstTimePredicted() then
	--	if newweapon.BurgerBase then
	--		newweapon.Primary.Automatic = true
	--	end
	--end

end


hook.Add("PlayerSwitchWeapon","BURGERBASE_HOOK_PlayerSwitchWeapon",BURGERBASE_HOOK_PlayerSwitchWeapon)