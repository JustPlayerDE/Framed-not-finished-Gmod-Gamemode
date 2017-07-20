local Targets = {}



	local function GetRandomPlayer(ply)

		local Random = table.Random(player.GetAll())
		local Player = ply

		if Random == ply then Random = GetRandomPlayer(Player) end
			for i,kk in pairs(Targets) do
				if kk == Random then Random = GetRandomPlayer(Player) end
			end

		return Random
	end


local function Start()
Targets = {}
	timer.Simple(1,function()

		for i,k in pairs(player.GetAll()) do
			local isinit = false
			if Targets[k] then isinit = true end


			if isinit then continue end
			local TheTarget  = GetRandomPlayer(ply)

			if TheTarget.CanBeTarget and k.CanBeTarget then
				Targets[k] = TheTarget
			end
			if k.CanBeTarget and Targets[k] then
			k:ChatPrint(Targets[k]:Name())
			print(k:Name(),">>",Targets[k]:Name())
			end
		end
 
	end)

end


hook.Add("FRAMED_RoundStarted","Test", Start)

