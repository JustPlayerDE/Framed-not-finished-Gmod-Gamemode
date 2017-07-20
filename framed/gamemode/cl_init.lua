-- Include some files
include( 'shared.lua' )
RoundStarted = false

function DrawLobby()
	local Frame = vgui.Create("DFrame")
	Frame:SetSize(ScrW()/2,ScrH()/2)
	Frame:Center()
	Frame:SetDraggable(false)
	Frame:SetDraggable(false)
	Frame:SetVisible(true)
	Frame:MakePopup()

end

net.Receive("OpenLobby",DrawLobby)
	local smooth = 100

local hide = {
	CHudHealth = true,
	CHudBattery = true,
	CHudAmmo = true,
}

hook.Add( "HUDShouldDraw", "HideHUD", function( name )
	if ( hide[ name ] ) then return false end
end )

hook.Add("HUDPaint","RenderHealthandso",function()

	if not RoundStarted then return end
	smooth = Lerp(1 * FrameTime(), smooth, LocalPlayer():Health())
	draw.RoundedBox(0,0,0,smooth*3,100,Color(255,122,122))

end)


function UpdateRoundStatus()
 RoundStarted = net.ReadBool()
end
net.Receive("RoundState",UpdateRoundStatus)