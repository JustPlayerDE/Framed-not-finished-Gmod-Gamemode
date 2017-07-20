AddCSLuaFile( "libraries/simplerr.lua" )
AddCSLuaFile( "libraries/fn.lua" )
AddCSLuaFile( "cl_init.lua" )
AddCSLuaFile( "shared.lua" )
 
-- Include Scripts
include("config/config.lua")

// net msgs
util.AddNetworkString("RoundState")
util.AddNetworkString("OpenLobby")
util.AddNetworkString("CloseLobby")
util.AddNetworkString("round_timer")




    PLAYER = FindMetaTable("Player")
    ENTITY = FindMetaTable("Entity")
    VECTOR = FindMetaTable("Vector")

// Including Stuff
include("stuff/player.lua")

local fol = GM.FolderName .. "/gamemode/modules/"
local files, folders = file.Find(fol .. "*", "LUA")

    function FRAMED.UpdateTimer(time)

        net.Start("round_timer")
        net.WriteInt(time,10)
        net.Broadcast()

    end
    function   FRAMED.BroadCast(txt)

        for i,k in pairs(player.GetAll()) do
            k:ChatPrint("[FRAMED] "..txt)
        end
    end

print("======================================================")
print("============== loading FRAMED modules ================")
print("======================================================")
for k, v in pairs(files) do
    if FRAMED.disabled["modules"][v:Left(-5)] then print("Disabled Module: "..v:Left(-5)) continue end
    if string.GetExtensionFromFilename(v) ~= "lua" then continue end
    include(fol .. v)

   
end

for _, folder in SortedPairs(folders, true) do
 print("Loading Module: "..folder)
    if folder == "." or folder == ".." or FRAMED.disabled["modules"][folder] then continue end
    for _, File in SortedPairs(file.Find(fol .. folder .. "/sh_*.lua", "LUA"), true) do
        AddCSLuaFile(fol .. folder .. "/" .. File)
        if File == "sh_interface.lua" then continue end
        include(fol .. folder .. "/" .. File)
    end

    for _, File in SortedPairs(file.Find(fol .. folder .. "/sv_*.lua", "LUA"), true) do
        if File == "sv_interface.lua" then continue end
        include(fol .. folder .. "/" .. File)
    end

    for _, File in SortedPairs(file.Find(fol .. folder .. "/cl_*.lua", "LUA"), true) do
        if File == "cl_interface.lua" then continue end
        AddCSLuaFile(fol .. folder .. "/" .. File)
    end
end
print("======================================================")
print("============== loaded FRAMED modules =================")
print("======================================================")




function GM:CreateTeams()
team.SetUp( 0, "Joining/Connecting", Color( 100, 100, 100, 30 ) ) // Joining
team.SetUp( 1, "Spectator", Color( 255, 120 , 120, 255 ) ) // Death
team.SetUp( 2, "Framed", Color( 120, 255 , 120, 255 ) ) // Playing
team.SetUp( 3, "Police", Color( 120, 255 , 120, 255 ) ) // COP
team.SetUp( 4, "Undercover", Color( 120, 255 , 120, 255 ) ) // Framed (Hidden COP)
end




-- Default GM Hooks stuff
function GM:Initialize()
	hook.Run("LoadingFramedGamemode")
		self.BaseClass.Initialize(self)




	hook.Run("LoadedFramedGamemode")
end




local NextResupplyTime = 0
    hook.Add("Think", "Resupply", function ()
        if (CurTime() >= NextResupplyTime) then
            for _, ply in pairs(player.GetAll()) do
                ply:SetAmmo( 999, "Pistol" )
            end
                NextResupplyTime = CurTime() + 1
         end 
end)


