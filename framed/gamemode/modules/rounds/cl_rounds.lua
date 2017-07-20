FRAMED = {}
local RoundStarted = false

	function FRAMED.UpdateRoundState()

		RoundStarted = net.ReadBool()
		print("Round Updated",RoundStarted)
	end

	function FRAMED.RoundStarted()

		return RoundStarted or false

	end
net.Receive("RoundState",FRAMED.UpdateRoundState)