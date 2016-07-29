BURGERBASE = {}

function BURGERBASE:INIT_Initialize()
	print("Initializing....")
	BURGERBASE:INIT_MassInclude("burgerbase/core/","shared",false)
	BURGERBASE:INIT_MassInclude("burgerbase/modules/","shared",true,1)
end


function BURGERBASE:INIT_MassInclude(folder,realm,includesub,times)

	if not times then 
		times = 1
	end

	local Files, Folders = file.Find(folder .. "*","LUA")

	local num,filename
	for num,filename in pairs(Files) do
		if realm == "shared" or realm == "client" then
			if CLIENT then
				print("[BURGERBASE] Attempting to include file:",folder .. filename)
			end
			include(folder .. filename)
			AddCSLuaFile(folder .. filename)
		end
		if realm == "shared" or realm == "server" then
			if SERVER then
				print("[BURGERBASE] Attempting to include file:",folder .. filename)
				include(folder .. filename)
			end
		end
	end

	if includesub and times >= 1 then
		times = times - 1
		local num,filename
		for num,foldername in pairs(Folders) do
			BURGERBASE:INIT_MassInclude(folder .. foldername .. "/",realm,includesub,times)
		end
	end

end

BURGERBASE.AmmoTypes = {}

function BURGERBASE:AddAmmoType(realname,ammodata)
	local CallName = ammodata.name
	game.AddAmmoType(ammodata)
	BURGERBASE.AmmoTypes[CallName] = realname
	print("Adding ammo type " .. CallName)
	if CLIENT then
		language.Add(CallName .. "_ammo",realname)
	end
end

function BURGERBASE:GetStoredAmmoType(callname)
	return BURGERBASE.AmmoTypes[callname]
end

BURGERBASE:AddAmmoType("12 Gauge Buckshot",{
	name = "bb_12gauge",
	dmgtype = DMG_BULLET,
})

BURGERBASE:AddAmmoType("5.7mm",{
	name = "bb_57mm",
	dmgtype = DMG_BULLET,
})

BURGERBASE:AddAmmoType(".45 ACP",{
	name = "bb_45acp",
	dmgtype = DMG_BULLET,
})

BURGERBASE:AddAmmoType("9mm",{
	name = "bb_9mm",
	dmgtype = DMG_BULLET,
})

BURGERBASE:AddAmmoType(".50 AE",{
	name = "bb_50ae",
	dmgtype = DMG_BULLET,
})

BURGERBASE:AddAmmoType("5.56mm",{
	name = "bb_556mm",
	dmgtype = DMG_BULLET,
})

BURGERBASE:AddAmmoType("7.62mm",{
	name = "bb_762mm",
	dmgtype = DMG_BULLET,
})

BURGERBASE:AddAmmoType(".338",{
	name = "bb_338",
	dmgtype = DMG_BULLET,
})

BURGERBASE:AddAmmoType(".357 SIG",{
	name = "bb_357sig",
	dmgtype = DMG_BULLET,
})

BURGERBASE:AddAmmoType("HE Grenade",{
	name = "bb_hegrenade",
	dmgtype = DMG_BLAST,
})

BURGERBASE:AddAmmoType("Flash Grenade",{
	name = "bb_flashgrenade",
	dmgtype = DMG_BLAST,
})

BURGERBASE:AddAmmoType("Smoke Grenade",{
	name = "bb_smokegrenade",
	dmgtype = DMG_BLAST,
})

BURGERBASE:INIT_Initialize()