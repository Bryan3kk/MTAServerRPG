-- [atenção] : Colocar o nome correto ! e ter certeza que é o lado do Cliente!


function protect ()
fileDelete("Client.lua") 
fileDelete("Tag.lua")
fileDelete("ClientAFK.lua")
fileDelete("clientAimbot.lua")
fileDelete("anticheat_c.lua")
fileDelete("debug_c.lua")
fileDelete("carblowfix.lua")
fileDelete("aircraft_client.lua")
fileDelete("clientVidaColete.lua")
fileDelete("main_client.lua")
fileDelete("sourceC.lua")
fileDelete("hudClient.lua")
fileDelete("s_client.lua")
fileDelete("clientAjuda.lua")
fileDelete("actualizacion-c.lua")
fileDelete("script.lua")
fileDelete("fuel-c.lua")
fileDelete("c.lua")
fileDelete("create.lua")
fileDelete("core_client.lua")
fileDelete("cVehRadio3D.lua")
fileDelete("SharksCl.lua")
fileDelete("clientTurf.lua")
fileDelete("hunger.lua")
fileDelete("ClientSpawnCar.lua")
fileDelete("Language.lua")
fileDelete("clientStamina.lua")
fileDelete("ClientResource.lua")
fileDelete("ClientWeapon.lua")
fileDelete("client2.lua")
fileDelete("tranvia_c.lua")
fileDelete("Crims_C.lua")
fileDelete("cp.lua")
fileDelete("planeC.lua")
fileDelete("arrest_client.lua")
fileDelete("ClientResource.lua")
fileDelete("ClientWeapon.lua")
fileDelete("lspd.lua")
fileDelete("lvpd.lua")
fileDelete("sfpd.lua")
fileDelete("weapons.lua")
fileDelete("crob.lua")
fileDelete("taxi_c.lua")
fileDelete("change_c.lua")
end
addEvent ("onClientPlayerLogin",true)
addEventHandler ("onClientPlayerLogin", root, protect)
