local scripts = {
    [142823291] = "games/mm2.lua",
}

local path = scripts[game.PlaceId]
if not path then 
  loadstring(game:HttpGet("https://raw.githubusercontent.com/fujidagoat/fujihub/refs/heads/main/resources/unsupported.lua"))()
  return 
end

loadstring(game:HttpGet("https://raw.githubusercontent.com/fujidagoat/fujihub/refs/heads/main/resources/loading.lua"))()
loadstring(game:HttpGet("https://raw.githubusercontent.com/fujidagoat/fujihub/refs/heads/main/" .. path))()

--https://raw.githubusercontent.com/fujidagoat/fujihub/refs/heads/main/resources/loading.lua
