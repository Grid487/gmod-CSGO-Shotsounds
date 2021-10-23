AddCSLuaFile();

// Precache
if SERVER then
	game.AddParticles("particles/hs_impact_fx.pcf")
end

if CLIENT then
	game.AddParticles("particles/hs_impact_fx.pcf")
	PrecacheParticleSystem("impact_helmet_headshot_csgo")
	PrecacheParticleSystem("blood_impact_headshot_1")
end