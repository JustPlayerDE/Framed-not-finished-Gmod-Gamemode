util.AddNetworkString("open_lobby")


function enterLobby()

	net.Start("open_lobby")
	net.Broadcast()

end


hook.Add("PlayerInitialSpawn","show_lobby",enterLobby)