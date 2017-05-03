local BURGERBASE_RegisteredBullets = {}

function BUREGRBASE_HOOK_Tick_Bullets()

	for num,data in pairs(BURGERBASE_RegisteredBullets) do
	
		data = table.Copy(data)
	
		data.pos = data.pos + ( data.direction * engine.TickInterval() )
		data.direction = data.direction - ( data.resistance * engine.TickInterval() )

		local TraceData = {}
		local HullSize = 5
	
	
		TraceData.start = data.pos - data.direction:GetNormalized()*HullSize
		TraceData.endpos = data.pos + data.direction:GetNormalized()*HullSize
		TraceData.maxs = Vector(HullSize,HullSize,HullSize)
		TraceData.mins = Vector(-HullSize,-HullSize,-HullSize)
		TraceData.mask = MASK_SHOT
		TraceData.filter = data.owner
	
		local TraceResult = util.TraceHull(TraceData)
		
		data.tickfunction(data)
		
		if TraceResult.Hit then
		
			data.hitfunction(data,TraceResult)
			data.diefunction(data)
			data = nil
			
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
	
	NewTable.resistance = datatable.resistance or Vector(0,0,0)
	NewTable.dietime = datatable.dietime or (CurTime() + 10)
	NewTable.special = datatable.special or false
	
	NewTable.hitfunction = datatable.hitfunction or function(datatable,traceresult) end
	NewTable.drawfunction = datatable.drawfunction or function(datatable) end
	NewTable.diefunction = datatable.diefunction or function(datatable) end
	NewTable.tickfunction = datatable.tickfunction or function(datatable) end
	
	table.Add(BURGERBASE_RegisteredBullets,{NewTable})

end

local BulletMat = Material( "sprites/physg_glow1" )


if CLIENT then

	 function BUREGRBASE_HOOK_3D_Bullets()
	 
		for num,data in pairs(BURGERBASE_RegisteredBullets) do
			data.drawfunction(data)
		end
	 
	 end
	 
	 hook.Add("PreDrawEffects","BUREGRBASE_HOOK_3D_Bullets",BUREGRBASE_HOOK_3D_Bullets)
	
end