BURGERBASE_RegisteredBullets = {}

if not BURGERBASE_RegisteredBulletTemplates then
	BURGERBASE_RegisteredBulletTemplates = {}
end

function BURGERBASE_RegisterProjectile(id,DataTable)
	BURGERBASE_RegisteredBulletTemplates[id] = DataTable
end


function BUREGRBASE_HOOK_Tick_Bullets()

	for num,data in pairs(BURGERBASE_RegisteredBullets) do
	
		data = table.Copy(data)
	
		data.pos = data.pos + ( data.direction * engine.TickInterval() )
		data.direction = data.direction - ( data.resistance * engine.TickInterval() )

		local TraceData = {}
		local HullSize = data.hullsize or 1
		
		TraceData.start = data.pos - ( data.direction * engine.TickInterval() )
		TraceData.endpos = data.pos
		TraceData.mask = MASK_SHOT
		TraceData.filter = data.owner
		
		local TraceResult = {}
		local TraceResultHull = {}
		
		TraceResult = util.TraceLine(TraceData)
	
		if data.usehull then
			TraceData.maxs = Vector(HullSize,HullSize,HullSize)
			TraceData.mins = Vector(-HullSize,-HullSize,-HullSize)
			TraceResultHull = util.TraceHull(TraceData)
		end
		
		
		
		data.tickfunction(data)
		
		if TraceResult.Hit then
			data.hitfunction(data,TraceResult)
			data.diefunction(data)
			data = nil
			--print("LINE HIT")
		elseif TraceResultHull.Hit and TraceResultHull.Entity and TraceResultHull.Entity:Health() > 0 then
			data.hitfunction(data,TraceResultHull)
			data.diefunction(data)
			data = nil
			--print("HULL HIT")
		elseif data.dietime <= CurTime() then
			data.diefunction(data)
			data = nil
		end

		if data == nil then
			table.remove(BURGERBASE_RegisteredBullets,num)
		else
			BURGERBASE_RegisteredBullets[num] = data
		end
		
	end

end

hook.Add("Tick","BUREGRBASE_HOOK_Tick_Bullets",BUREGRBASE_HOOK_Tick_Bullets)

function BURGERBASE_HOOK_PostCleanupMap_Bullets()
	BURGERBASE_RegisteredBullets = {}
end

hook.Add("PostCleanupMap","BURGERBASE_HOOK_PostCleanupMap_Bullets",BURGERBASE_HOOK_PostCleanupMap_Bullets)

local DefaultMaterial = Material("sprites/physg_glow1")

function BURGERBASE_FUNC_AddBullet(datatable)

	local NewTable = {}
	NewTable.weapon = datatable.weapon
	NewTable.owner = datatable.owner
	NewTable.pos = datatable.pos
	NewTable.direction = datatable.direction

	NewTable.damage = datatable.damage or 10
	NewTable.hullsize = datatable.hullsize or 1
	NewTable.usehull = datatable.usehull or false
	
	NewTable.resistance = datatable.resistance or Vector(0,0,0)
	NewTable.dietime = datatable.dietime or (CurTime() + 10)
	
	NewTable.id = datatable.id or "crossbow_bolt"

	if SERVER then
		net.Start("BURGERBASE_SendBulletToClient")
			net.WriteTable(NewTable)
			net.WriteFloat(SysTime())
		net.Broadcast()
	end
	
	local RegisteredTable = BURGERBASE_RegisteredBulletTemplates[NewTable.id] or {}
	NewTable.drawfunction = RegisteredTable.drawfunction or function(data) end
	NewTable.diefunction = RegisteredTable.diefunction or function(data) end
	NewTable.tickfunction = RegisteredTable.tickfunction or function(data) end
	NewTable.hitfunction = RegisteredTable.hitfunction or function(data,traceresult) end

	table.Add(BURGERBASE_RegisteredBullets,{NewTable})

end

if SERVER then
	util.AddNetworkString( "BURGERBASE_SendBulletToClient" )
end

local BulletMat = Material( "sprites/physg_glow1" )

if CLIENT then

	net.Receive("BURGERBASE_SendBulletToClient", function(len)
	
		local DataTable = net.ReadTable()
		local ServerSysTimeDif = SysTime() - net.ReadFloat()
		local id = DataTable.id
		
		--DataTable.pos = DataTable.pos + (DataTable.direction * ServerSysTimeDif)
		
		
		
		table.Add(DataTable,BURGERBASE_RegisteredBulletTemplates[id])

		if LocalPlayer() ~= DataTable.owner then
			BURGERBASE_FUNC_AddBullet(DataTable)
		end
		
	end)

	 function BUREGRBASE_HOOK_3D_Bullets()
	 
		for num,data in pairs(BURGERBASE_RegisteredBullets) do
			data.drawfunction(data)
		end
	 
	 end
	 
	 hook.Add("PreDrawEffects","BUREGRBASE_HOOK_3D_Bullets",BUREGRBASE_HOOK_3D_Bullets)
	
end