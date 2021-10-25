AddCSLuaFile();

-- if ( CLIENT ) then return end

if (SERVER) then 

	function CSGO_S_NPC_HELMET_HEADSHOT( ent , hitgroup , dmginfo )
		if not IsValid( ent ) then return end
		
		local attacker					=	dmginfo:GetAttacker()
		local plyangle					=	attacker:GetAngles()
		local dmgpos					=	dmginfo:GetDamagePosition()
		
		if hitgroup == HITGROUP_HEAD then
			
			if not IsValid( attacker ) or attacker:IsPlayer() == true or attacker:IsNPC()  == true then
													
				ParticleEffect( "impact_helmet_headshot_csgo" , dmginfo:GetDamagePosition(), Angle(plyangle), nil)																
				ent:EmitSound( "headshot_csgo/headshot_csgo.wav" , 80 , 100 , 0.4 )				
								
			end
			
		end
		
	end
	
	function CSGO_S_NPC_COMBINE_BODYSHOT( ent , hitgroup , dmginfo )
		if not IsValid( ent ) or ent:IsPlayer() == true then return end
		
		local attacker					=	dmginfo:GetAttacker()
		local plyangle					=	attacker:GetAngles()
		
		if hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH or hitgroup == HITGROUP_LEFTARM or hitgroup == HITGROUP_RIGHTARM or hitgroup == HITGROUP_GEAR or HITGROUP_GENERIC  then
			
			print(ent:GetClass())
			if ( ent:GetClass() == "npc_combine_s" or ent:GetClass() == "npc_metropolice" ) then 
			
				if attacker:IsPlayer() == true or attacker:IsNPC() == true then
					
					
						local particleSound		=	ents.Create( "env_spark" )
						local randomizer = math.random( 1 , 5 )
						
						particleSound:SetPos( dmginfo:GetDamagePosition() )
						particleSound:Spawn()					
						particleSound:EmitSound( "bodyshot_csgo/kevlar" .. randomizer .. ".wav" , 80 , 100 , 0.85 )	
						
						print("bodyshot random " .. randomizer )
						
						timer.Simple( 0.05 , function()
							
							if IsValid( particleSound ) then
								
								particleSound:Remove()
								
							end
							
						end)

				end
				
			end
			
		end
		
	end

	function CSGO_S_ON_NPC_KILL_HEADSHOT( target , hitgroup , dmginfo )

		if target:IsPlayer() == true then return end
		
		local attacker				=	dmginfo:GetAttacker()
		
		if hitgroup == HITGROUP_HEAD then
			
			print( "ogey 1" )
			
			if attacker:IsPlayer() == true or attacker:IsNPC()  == true then
				
				-- local number = attacker:EntIndex()
				-- local targetnumber = target:EntIndex()
				
				-- print( "GetDamage() " .. dmginfo:GetDamage() )
				-- somehow dmginfo:GetDamage() number is halved??
				-- print( "Health() " .. target:Health() )
				-- print( "GetMaxHealth() " .. target:GetMaxHealth() )
				-- print( "GetDamageType() " .. dmginfo:GetDamageType() )
				-- print( "" )
				
				if dmginfo:GetDamage()*2 >= target:Health() then
				
					local randomizer = math.random( 1 , 2 )
					target:EmitSound( "headshot_csgo/headshot_nohelm" .. randomizer .. ".wav" , 80 , 100 , 1 )	
					-- print( "nohelm randomizer " .. randomizer )	
					
				end
				
			end
			
		end
		
	end

	function CSGO_S_PLAYER_SHOTS( ply , hitgroup , dmginfo )
		if not IsValid( ply ) then return 
		end
		
		local attacker					=	dmginfo:GetAttacker()
		
		if hitgroup == HITGROUP_HEAD then
			
			if attacker:IsPlayer() == true or attacker:IsNPC() == true then
				
				if ply:Armor() < 1 then
				
					local particleSound		=	ents.Create( "env_spark" )
					local randomizer = math.random( 1 , 2 )
					
					particleSound:SetPos( dmginfo:GetDamagePosition() )
					particleSound:Spawn()
					ParticleEffect( "blood_impact_headshot_1" , dmginfo:GetDamagePosition(), Angle(plyangle), nil)	
					particleSound:EmitSound( "headshot_csgo/headshot_nohelm" .. randomizer .. ".wav" , 80 , 100 , 1 )	
					
					timer.Simple( 0.05 , function()
						
						if IsValid( particleSound ) then
							
							particleSound:Remove()
							
						end
						
					end)												
					
				elseif ply:Armor() > 0 then
				
				local particleSound		=	ents.Create( "env_spark" )
					local randomizer = math.random( 1 , 2 )
					
					particleSound:SetPos( dmginfo:GetDamagePosition() )
					particleSound:Spawn()
					ParticleEffect( "impact_helmet_headshot_csgo" , dmginfo:GetDamagePosition(), Angle(plyangle), nil)	
					particleSound:EmitSound( "headshot_csgo/headshot_csgo.wav" , 80 , 100 , 0.4 )	
					
					timer.Simple( 0.05 , function()
						
						if IsValid( particleSound ) then
							
							particleSound:Remove()
							
						end
						
					end)
				
				end							
																		
			end					
			
		elseif hitgroup == HITGROUP_CHEST or hitgroup == HITGROUP_STOMACH then
			
				if attacker:IsPlayer() == true or attacker:IsNPC() == true then
					
					if ply:Armor() > 0 then
						local particleSound		=	ents.Create( "env_spark" )
						local randomizer = math.random( 1 , 5 )
						
						particleSound:SetPos( dmginfo:GetDamagePosition() )
						particleSound:Spawn()
						ParticleEffect( "blood_impact_headshot_1" , dmginfo:GetDamagePosition(), Angle(plyangle), nil)	
						particleSound:EmitSound( "bodyshot_csgo/kevlar" .. randomizer .. ".wav" , 80 , 100 , 1 )	
						
						print("bodyshot random " .. randomizer )
						
						timer.Simple( 0.05 , function()
							
							if IsValid( particleSound ) then
								
								particleSound:Remove()
								
							end
							
						end)
						
					else									
						
					end							
																		
				end
				
		end
		
	end

	function CSGO_S_HOOKS()
		
		hook.Add( "ScaleNPCDamage" , "CSGO_S_Npc_Helmet_Headshot" , CSGO_S_NPC_HELMET_HEADSHOT )	
		hook.Add( "ScaleNPCDamage" , "CSGO_S_Npc_Combine_Bodyshot" , CSGO_S_NPC_COMBINE_BODYSHOT )	
		hook.Add( "ScaleNPCDamage" , "CSGO_S_On_Npc_Kill_Headshot" , CSGO_S_ON_NPC_KILL_HEADSHOT )	
		hook.Add( "ScalePlayerDamage" , "CSGO_S_Player_Shots" , CSGO_S_PLAYER_SHOTS )	
		
		print("csgo headshots loaded ogey")
		
	end

	timer.Simple( 1 , CSGO_S_HOOKS )

end

CreateConVar("csgo_s_enable" , "1" , "","", "0" , "1")
csgo_s_enable = GetConVar("csgo_s_enable")




























