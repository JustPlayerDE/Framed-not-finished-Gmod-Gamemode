
	function GM:PlayerConnect(name,ip)
		if ip == "loopback" then ip = "localhost" end
		print(name.." connected ("..ip..")")
	end


	function GM:PlayerInitialSpawn(ply)
		print("Player "..ply:Name().." has spawned.")
		ply:SetTeam(0)
		ply:SetSpec()
	end



	function GM:PlayerDeath(ply,ent,attacker)

		print(ply:Name(),ent:GetClass(),attacker:Name())
		if ply.IsUnderCover then
			if attacker.IsCop then attacker.DoNotSpect = true attacker:SetFramed() attacker:ChatPrint("<<<<You are Fired because you has killed an Undercover!>>>>") end

		end
	end

	function GM:DoPlayerDeath(ply,ent,attacker)

			FRAMED.BroadCast(ply:Name().." is dead")


		if ply.IsUnderCover then
			if attacker.IsCop then attacker:SetFramed() end
			FRAMED.BroadCast("The UnderCover has dyed!")
		end


	end

	function GM:PlayerShouldTakeDamage( ply, attacker )

		if FRAMED.RoundStarted() then

			if FRAMED.InTbl(FRAMED.COPS,ply) and FRAMED.InTbl(FRAMED.COPS,attacker) then return false end
			ply.Dead = true
			return true
		else
			return false
		end
	end

	function GM:PlayerSpawn(ply)
		FRAMED.CheckForGameEnd()
			if FRAMED.RoundStarted() then if not ply.DoNotSpect then ply:SetSpec() else  ply.DoNotSpect = false end end
			ply.IsCop = false

			ply:SetModel("models/player/kleiner.mdl")
			ply.IsFramed = false
			ply.IsUnderCover = false
			ply.CanBeTarget = false
			ply:SetCollisionGroup( COLLISION_GROUP_WORLD )
		ply:Flashlight( false )
		ply:AllowFlashlight( true )
	end
	function GM:PlayerDisconnected(ply)
		FRAMED.CheckForGameEnd()
		FRAMED.BroadCast( ply:Name().." has left the game!")		
	end

	function PLAYER:SetCop()
		print("PLAYER",self:Name(),"COP")
		self:UnSpectate()
			self:ChatPrint(" ")
			self:ChatPrint(" ")
			self:ChatPrint(" ")
			self:ChatPrint(" ")
			self:ChatPrint("[FRAMED] You Are Cop!")
			self:ChatPrint("[FRAMED] Kill anybody that you see with a weapon!")
			self:ChatPrint("[FRAMED] But be aware if killing an Undercover!")
			self:Spawn()

			self:SetTeam(3)
			self:SetModel("models/player/police.mdl")
			self.IsCop = true
			self.IsFramed = false
			self.IsUnderCover = false
			self:GivePlayerWeapons()
			self:SetupHands()
	end
	function PLAYER:SetUnderCover()
			self:UnSpectate()
			self:ChatPrint(" ")
			self:ChatPrint(" ")
			self:ChatPrint(" ")
			self:ChatPrint(" ")
		print("PLAYER",self:Name(),"COP[UNDERCOVER]")
		self:ChatPrint("[FRAMED] You Are UnderCover!")
			self:ChatPrint("[FRAMED] Kill anybody that you see with a weapon!")
			self:ChatPrint("[FRAMED] Show your badge with /Show to show the Police that you are UnderCover!")
			self:Spawn()
			self:SetTeam(4)
		self:SetModel("models/player/barney.mdl")
			self.IsCop = false
			self.IsFramed = false
			self.IsUnderCover = true
			self:GivePlayerWeapons()
			self:SetupHands()
	end
	function PLAYER:SetFramed()
			self:UnSpectate()
			self:ChatPrint(" ")
			self:ChatPrint(" ")
			self:ChatPrint(" ")
			self:ChatPrint(" ")
		print("PLAYER",self:Name(),"FRAMED")
			self:ChatPrint("[FRAMED] You Are Framed!")
			self:ChatPrint("[FRAMED] Kill your target!")
			self:ChatPrint("[FRAMED] But the Police will stop you if he see your weapon!")
			self:Spawn()
			self:SetTeam(2)
			self:SetModel("models/player/barney.mdl")
			self.IsCop = false
			self.CanBeTarget = true
			self.IsFramed = true
			self.IsUnderCover = false
			self:GivePlayerWeapons()
			self:SetupHands()
	end
	function PLAYER:SetSpec()
		print("PLAYER",self:Name(),"SPECTATOR")
			self:ChatPrint("[FRAMED] You are Dead")
			self.CanBeTarget = false

		self:Flashlight( false )
		self:AllowFlashlight( false )
			self:SetSpectator(true)
	end




function PLAYER:Unassigned( )
	if ( self:Team( ) == TEAM_UNASSIGNED || self:Team( ) == TEAM_SPECTATOR ) then
		return true;
	end

	return false;
end

function PLAYER:CanRespawn( )
	if ( self:Unassigned( ) ) then
		//return false;
	end


	
	return true;
end
	function PLAYER:GivePlayerWeapons()
		for k,v in pairs(FRAMED.Weapons) do
			self:Give(v)
		end
	end
function GM:PlayerInitialSpawn( Player )
	Player:SetTeam( TEAM_SPECTATOR );
end



function GM:PlayerDeathThink( Player )
	if ( !Player:CanRespawn( ) ) then
		return false;
	else
		Player:Spawn( )
	end
end


function PLAYER:SetSpectator(bool)

			if bool then
				self:StripAmmo( )
				self:StripWeapons( );
				self:Spectate( OBS_MODE_ROAMING )
				self:SetTeam(1)
			self.IsCop = false
			self.IsFramed = false
			self.IsUnderCover = false

				return false;
			else
				self:UnSpectate()
			end

end

