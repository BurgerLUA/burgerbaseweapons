function BURGERBASE_HOOK_PlayerInitialSpawn( ply )

	ply:SendLua(
		[[chat.AddText(Color(255,255,255), "This server is running CSS weapons. Enter",Color(0,255,0)," !cssplayer ",Color(255,255,255),Color(255,255,255),"to access the player menu.")]]
	)
	
	if not game.IsDedicated() then	
		if ply == Entity(1) then
			ply:SendLua(
				[[chat.AddText(Color(255,255,255), "Enter",Color(0,255,0)," !cssadmin ",Color(255,255,255),Color(255,255,255),"to access the admin menu.")]]
			)
		end
	end

end

hook.Add( "PlayerInitialSpawn", "BURGERBASE_HOOK_PlayerInitialSpawn", BURGERBASE_HOOK_PlayerInitialSpawn )





