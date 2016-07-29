function BURGERBASE_HOOK_Move(ply,mv)
	--print("Hello?")
	if BURGERBASE then
		if BURGERBASE:CONVARS_GetStoredConvar("sv_burgerbase_speedmod",false):GetBool() then
		
			local ActiveWeapon = ply:GetActiveWeapon()
			
			local BaseSpeed = 250
			local WeaponSpeed = 250
			
			if ActiveWeapon and ActiveWeapon ~= NULL and ActiveWeapon.CSSMoveSpeed then
				WeaponSpeed = ActiveWeapon.CSSMoveSpeed
			end

			if WeaponSpeed ~= -1 then
				local PreviousLimit = mv:GetMaxSpeed()
				local SpeedMod = (WeaponSpeed / BaseSpeed)
				local PrevMaxSpeed = mv:GetMaxSpeed()
				mv:SetMaxSpeed( PreviousLimit * SpeedMod )
				mv:SetMaxClientSpeed( PreviousLimit * SpeedMod )
			end

		end
	end

end

hook.Add("Move","BURGERBASE_HOOK_Move",BURGERBASE_HOOK_Move)