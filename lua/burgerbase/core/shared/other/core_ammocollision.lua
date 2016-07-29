function BURGERBASE_HOOK_ShouldCollide(ent1,ent2)
	if ent1:GetClass() == "ent_burger_core_ammo" or ent1:GetClass() == "ent_burger_core_dropped_weapon" then
		if ent1:GetClass() == ent2:GetClass() then
			return false
		end
	end
end

hook.Add("ShouldCollide","BURGERBASE_HOOK_ShouldCollide",BURGERBASE_HOOK_ShouldCollide)
