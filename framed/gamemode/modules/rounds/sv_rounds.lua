

FRAMED = FRAMED or {} // Function table
// Setup default var
// Globals
FRAMED.COPS = {}
FRAMED.FRAMED = {}
FRAMED.UNDERCOVER = {}
// locals
	 RoundStarted = false
	local StartTime = 0
	local StopTime = 0

	local MinimumPlayers = GetConVar("framed_minplayer") or 4
	local TimePerRound = GetConVar("framed_roundtime") or 60
	local CopsInPercent = GetConVar("framed_percentcops") or 30
	local TotalUnderCover = GetConVar("framed_totalundercover") or 1

	
	local TotalCopsThisRound = 0









	function FRAMED.Start()
		FRAMED.BroadCast("New Round in 30 seconds!")
		FRAMED.UpdateTimer(30)
			timer.Create("round",1,30,function()

				//PrintMessage(HUD_PRINTTALK," New Round in ".. timer.RepsLeft("round"))
				if timer.RepsLeft("round") != 0 and timer.RepsLeft("round") < 6 then FRAMED.BroadCast("New Round in "..timer.RepsLeft("round").."") end
				if timer.RepsLeft("round") <= 0 then
					if #player.GetAll() < MinimumPlayers then FRAMED.BroadCast("Not Enough Players! next try in 40 seconds!") FRAMED.UpdateTimer(40) print("Not Enough Players To Start!") timer.Adjust("round",1,40) return end
					PrintMessage(HUD_PRINTTALK,"Round Started!")

					if not FRAMED.RoundStarted() then
					if #player.GetAll() < MinimumPlayers then  print("Not Enough Players To Start!") return false end
					StartTime = os.time()
					StopTime = StartTime + TimePerRound

					local CopsSelect = math.Round(#player.GetAll()/100*CopsInPercent,0)
					print(CopsSelect)
					FRAMED.COPS = GetCops(CopsSelect) or {}
					FRAMED.UNDERCOVER = GetUnderCover(TotalUnderCover) or{}
					FRAMED.FRAMED = GetFrames() or {}

					FRAMED.ClearMap()
					FRAMED.SetPlayer(FRAMED.COPS,FRAMED.UNDERCOVER,FRAMED.FRAMED)
					FRAMED.SetRoundState(true)
					hook.Run("FRAMED_RoundStarted")
							timer.Create("round_2",1,TimePerRound,function()
								PrintMessage(HUD_PRINTCENTER,"Round Ends in "..timer.RepsLeft("round_2"))

								if timer.RepsLeft("round_2") <= 0 then
									FRAMED.BroadCast("Round Ended!")
									FRAMED.Stop()
									FRAMED.Start()
								end 
							end)
					end

				end
			end)

		
	end

	function FRAMED.Stop()
		FRAMED.TriggerLobbyMenu()
		FRAMED.COPS = {}
		FRAMED.UNDERCOVER = {}
		FRAMED.FRAMED = {}

			FRAMED.ClearMap()

		if FRAMED.RoundStarted() then
		FRAMED.SetRoundState(false)
					hook.Run("FRAMED_RoundStopped")
		 StartTime = 0
		 StopTime = 0


		end

	end

	function FRAMED.RoundStarted()

		return RoundStarted or false

	end
	function FRAMED.SetRoundState(bool)
		RoundStarted = bool
		FRAMED.UpdateRoundClients()

	end


	function FRAMED.UpdateRoundClients()
		net.Start("RoundState")
		net.WriteBool(FRAMED.RoundStarted())
		net.Broadcast()
	end

	function FRAMED.SetPlayer(cops,undercovers,frames)

		for i,k in pairs(cops) do if k:IsValid() then k:SetCop() end end
		for i,k in pairs(undercovers) do  if k:IsValid() then k:SetUnderCover() end end
		for i,k in pairs(frames) do if k:IsValid() then k:SetFramed() end end

	end


	// Some Thirdparty Functions

function FRAMED.StartUp()

FRAMED.Start()
end


FRAMED.StartUp()


	function FRAMED.InTbl(SomeTable,SomeItem)
		SomeTable = SomeTable or {}
		SomeItem = SomeItem or ""
		return table.HasValue(SomeTable,SomeItem) or false
	end

	function FRAMED.ClearMap()

		for i,k in pairs(player.GetAll()) do if k:IsValid() and k:IsPlayer() and k:Alive() then k.Dead = nil k:StripAmmo() k:StripWeapons() k:KillSilent() end end
		print("Player Cleared")
		game.CleanUpMap()
		print("Map Cleared")

	end

	function FRAMED.DoSpawnPlayer()

		for i,k in pairs(player.GetAll()) do
			if k:IsValid() and k:IsPlayer() then

			end
		end

	end

	function GetCops(TotalCops)
		local MaxCops = TotalCops or 1
		local CurrentCops = {}
		while MaxCops > 0 do
			local RandomPlayer = table.Random(player.GetAll())
			if not RandomPlayer:IsValid() then continue end
			if not table.HasValue(CurrentCops,RandomPlayer) then
				table.insert(CurrentCops,RandomPlayer)
				MaxCops = MaxCops -1
			end
		end
		return CurrentCops
	end

	function GetUnderCover(TotalUnderCover)
		local MaxCops = TotalUnderCover or 1
		local CurrentUnderCover = {}
		while MaxCops > 0 do
			local RandomPlayer = table.Random(player.GetAll())
			if not RandomPlayer:IsValid() then continue end
			if not (table.HasValue(FRAMED.COPS,RandomPlayer) or table.HasValue(CurrentUnderCover,RandomPlayer)) then
				table.insert(CurrentUnderCover,RandomPlayer)
				MaxCops = MaxCops -1
			end
		end
		return CurrentUnderCover
	end
	function GetFrames()
		local CurrentFrames = {}
		for i,k in pairs(player.GetAll()) do
			if not (table.HasValue(FRAMED.COPS,k) or table.HasValue(FRAMED.UNDERCOVER,k)) then
				table.insert(CurrentFrames,k)
			end
		end
		return CurrentFrames
	end



function FRAMED.CheckForGameEnd()
local LastCheck = os.time()
local Wait = 0
local StartedRound = FRAMED.RoundStarted() or false
	if LastCheck >= Wait then 
		if StartedRound then
			Wait = LastCheck + 5
			local playertbl = player.GetAll()
			local count = #player.GetAll()
			if (count < MinimumPlayers) then print("Not Enough Players To Play!")
				FRAMED.BroadCast("Not Enough players, game stopped!")
				timer.Adjust("round_2",1,1)
			end

			local alives = {}
			alives.frames = 0
			alives.cops = 0
			for i,k in pairs(player.GetAll()) do
				if k:IsValid() and k:Alive() then 
					if k.IsFramed == true then
						alives.frames = alives.frames +1
					end
					if k.IsCop == true then
						alives.cops = alives.cops +1
					end
				end
			end
			print(alives.cops,alives.frames)
			if (alives.cops <= 0 and alives.frames == 1) or (alives.frames <= 1 and alives.cops < 1) then 
				FRAMED.BroadCast("Not Enough Players Alive! Stopping game.")
				timer.Adjust("round_2",1,1)
			end
		end
	end

end


	//hook.Add("Think","CheckForGameEnding",FRAMED.CheckForGameEnd)

 function FRAMED.TriggerLobbyMenu()
		net.Start("OpenLobby")
		net.Broadcast()
end