




function openLobby()
local Frame = vgui.Create( "DFrame" )
Frame:SetTitle( "Welcome" )
Frame:SetSize( 400, 200)
Frame:Center()
Frame:MakePopup()
Frame.Paint = function( self, w, h ) 
	draw.RoundedBox( 0, 0, 0, w, h, Color( 100, 100, 200, 255 ) )
end

local Button = vgui.Create( "DButton", Frame )
Button:SetText( "Speichern" )
Button:SetTextColor( Color( 255, 255, 255 ) )
Button:SetPos(0, 180 )
Button:SetSize( 400, 20 )
Button.Paint = function( self, w, h )
	draw.RoundedBox( 0, 0, 0, w, h, Color( 41, 128, 185, 250 ) ) -- Draw a blue button
end
Button.DoClick = function()
	
	/*net.Start("ForceAFackedRPNameYouSkidreceive")
	net.WriteString("name")
	net.WriteString("nachname")
	net.SendToServer()*/
	Frame:Close()
end

end


net.Receive("open_lobby",openLobby)