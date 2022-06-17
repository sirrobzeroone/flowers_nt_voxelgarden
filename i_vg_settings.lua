----------------------------------------------------------
--        ___ _                         _  _ _____      --
--       | __| |_____ __ _____ _ _ ___ | \| |_   _|     --
--       | _|| / _ \ V  V / -_) '_(_-< | .` | | |       --
--       |_| |_\___/\_/\_/\___|_| /__/ |_|\_| |_|       --
----------------------------------------------------------
--                 MTG Flowers Register                 --
----------------------------------------------------------
--------------------------
-- Disable flowers abns --
--------------------------
flowers_nt.disable_abm("Mushroom spread")

--------------
-- Mushroom --
--------------

flowers_nt.register_flower({
							flower_name = "Red Mushroom", --"Fly Agaric Toadstool",
							stage_5_name= " Spores",
							grow_on     = {"default:dirt",
							               "default:dirt_with_grass",
										   "default:dirt_with_coniferous_litter"
									      },
							biomes      = {"coniferous_forest", "deciduous_forest"},
							biome_seed  = 2,
							cover       = 3,
							light_min   = 10,
							light_max   = 14,
							light_max_death = true,
							time_min    = 60,
							time_max    = 180,
							sounds      = default.node_sound_leaves_defaults(),
							sel_box     = {-0.35,-0.5,-0.35, 0.35, 0.125, 0.35},
							e_groups    = {falling_node = 1},
							existing    = "flowers:mushroom_red",
							on_use      = minetest.item_eat(-1)
})

flowers_nt.register_flower({
							flower_name = "Brown Mushroom",
							stage_5_name= " Spores",
							grow_on     = {"default:dirt",
							               "default:dirt_with_grass",
										   "default:dirt_with_coniferous_litter"
									      },
							biomes      = {"coniferous_forest", "deciduous_forest"},
							biome_seed  = 2,
							cover       = 3,
							light_min   = 6,
							light_max   = 14,
							light_max_death = true,
							time_min    = 60,
							time_max    = 180,
							y_min       = -50,
							y_max       = 31000,
							sounds      = default.node_sound_leaves_defaults(),
							sel_box     = {-0.35,-0.5,-0.35, 0.35, 0.125, 0.35},
							e_groups    = {falling_node = 1},
							existing    = "flowers:mushroom_brown",
							on_use      = minetest.item_eat(1)
})


-- convert any mushroom spores in player inventory
minetest.register_on_joinplayer(function(player)
	
	local inv_replace
	
	if flowers_nt.rollback then
		inv_replace = {["flowers_nt_voxelgarden:brown_mushroom_5"] = "flowers:mushroom_brown_spores", 
					   ["flowers_nt_voxelgarden:red_mushroom_5"]   = "flowers:mushroom_red_spores"}
	else
		inv_replace = {["flowers:mushroom_brown_spores"] = "flowers_nt_voxelgarden:brown_mushroom_5", 
					   ["flowers:mushroom_red_spores"]   = "flowers_nt_voxelgarden:red_mushroom_5"}
	end						 
	local inv = player:get_inventory()
	
	for i_tar,i_rep in pairs(inv_replace) do		
		if inv:contains_item("main", i_tar) then
			local main_inv = inv:get_list("main")
			
			for i,itemstack in pairs(main_inv) do
				if itemstack:get_name() == i_tar then
					inv:remove_item("main", ItemStack(itemstack:get_name().." "..itemstack:get_count()))
					
					if i_rep ~= "air" then
						inv:set_stack("main", i, ItemStack(i_rep.." "..itemstack:get_count()))
					end				
					minetest.chat_send_player(player:get_player_name(),"Flowers_NT replace spores: "..itemstack:get_name().." replaced with "..i_rep.." x"..itemstack:get_count())					
				end
			end						
		end
	end
end)

-- unregister voxelgarden spores convert any placed to seed ie "_5"
if not flowers_nt.rollback then
	minetest.unregister_item("flowers:mushroom_brown_spores")
	minetest.unregister_item("flowers:mushroom_red_spores")	
	
	minetest.register_lbm({
		  name = "flowers_nt_voxelgarden:convert_vg_spores",
		  run_at_every_load = false, 
		  nodenames = {"flowers:mushroom_brown_spores",
					   "flowers:mushroom_red_spores"},
		  action = function(pos, node)
						if minetest.get_node(pos).name == "flowers:mushroom_brown_spores" then				
							minetest.set_node(pos, {name="flowers_nt_voxelgarden:brown_mushroom_5"})				
						else				
							minetest.set_node(pos, {name="flowers_nt:red_mushroom_5"})				
						end
	end})
	
end

-------------
-- Flowers --
-------------
flowers_nt.register_flower({
							flower_name = "Yellow Dandelion",
							grow_on     = {"default:dirt",
							               "default:dirt_with_grass"
									      },
							biomes      = {"grassland", "deciduous_forest"},
							biome_seed  = 1220999,
							cover       = 4,
							light_min   = 12,
							light_max   = 15,
							time_min    = 60,
							time_max    = 180,
							drawtype    = "torchlike",
							sounds      = default.node_sound_leaves_defaults(),
							color       = "yellow",
							sel_box     = {-0.35,-0.5,-0.35, 0.35, 0.35, 0.35},
							e_groups    = {falling_node = 1},
							existing    = "flowers:dandelion_yellow"
})

flowers_nt.register_flower({
							flower_name = "White Dandelion",
							grow_on     = {"default:dirt",
							               "default:dirt_with_grass"
									      },
							biomes      = {"grassland", "deciduous_forest"},
							biome_seed  = 73133,
							cover       = 4,
							light_min   = 12,
							light_max   = 15,
							time_min    = 60,
							time_max    = 180,
							drawtype    = "torchlike",
							sounds      = default.node_sound_leaves_defaults(),
							color       = "white",
							sel_box     = {-0.25,-0.5,-0.25, 0.25, 0.10, 0.25},
							e_groups    = {falling_node = 1},
							existing    = "flowers:dandelion_white"
})

flowers_nt.register_flower({
							flower_name = "Geranium",
							grow_on     = {"default:dirt",
							               "default:dirt_with_grass"
									      },
							biomes      = {"grassland", "deciduous_forest"},
							biome_seed  = 36662,
							cover       = 4,
							light_min   = 12,
							light_max   = 15,
							time_min    = 60,
							time_max    = 180,
							drawtype    = "torchlike",
							sounds      = default.node_sound_leaves_defaults(),
							color       = "blue",
							sel_box     = {-0.25,-0.5,-0.25, 0.25, 0.4, 0.25},
							e_groups    = {falling_node = 1},
							existing    = "flowers:geranium"
})

flowers_nt.register_flower({
							flower_name = "Rose",
							grow_on     = {"default:dirt",
							               "default:dirt_with_grass"
									      },
							biomes      = {"grassland", "deciduous_forest"},
							biome_seed  = 436,
							cover       = 4,
							light_min   = 12,
							light_max   = 15,
							time_min    = 60,
							time_max    = 180,
							drawtype    = "torchlike",
							sounds      = default.node_sound_leaves_defaults(),
							color       = "red",
							sel_box     = {-0.25,-0.5,-0.25, 0.25, 0.5, 0.25},
							e_groups    = {falling_node = 1},
							existing    = "flowers:rose"
})

flowers_nt.register_flower({
							flower_name = "Tulip",
							grow_on     = {"default:dirt",
							               "default:dirt_with_grass"
									      },
							biomes      = {"grassland", "deciduous_forest"},
							biome_seed  = 19822,
							cover       = 4,
							light_min   = 12,
							light_max   = 15,
							time_min    = 60,
							time_max    = 180,
							drawtype    = "torchlike",
							sounds      = default.node_sound_leaves_defaults(),
							color       = "orange",
							sel_box     = {-0.25,-0.5,-0.25, 0.25, 0.35, 0.25},
							e_groups    = {falling_node = 1},
							existing    = "flowers:tulip"
})

flowers_nt.register_flower({
							flower_name = "Viola",
							grow_on     = {"default:dirt",
							               "default:dirt_with_grass"
									      },
							biomes      = {"grassland", "deciduous_forest"},
							biome_seed  = 1133,
							cover       = 4,
							light_min   = 12,
							light_max   = 15,
							time_min    = 60,
							time_max    = 180,
							drawtype    = "torchlike",
							sounds      = default.node_sound_leaves_defaults(),
							color       = "violet",
							sel_box     = {-0.25,-0.5,-0.25, 0.25, 0.10, 0.25},
							e_groups    = {falling_node = 1},
							existing    = "flowers:viola"
})

------------------------
-- Flowers Water Lily --
------------------------
if not flowers_nt.rollback then

-- Convert any waterlilys in inventories
	minetest.register_on_joinplayer(function(player)	
		local inv_replace = {["flowers:waterlily"] = "flowers:waterlily_waving"}						   
		local inv = player:get_inventory()
				
		for i_tar,i_rep in pairs(inv_replace) do
			if inv:contains_item("main", i_tar) then
				local main_inv = inv:get_list("main")
				
				for i,itemstack in pairs(main_inv) do
				minetest.debug(itemstack:get_name())
					if itemstack:get_name() == i_tar then
						inv:remove_item("main", ItemStack(itemstack:get_name().." "..itemstack:get_count()))
						
						if i_rep ~= "air" then
							inv:set_stack("main", i, ItemStack(i_rep.." "..itemstack:get_count()))
						end				
						minetest.chat_send_player(player:get_player_name(),"Flowers_NT replace: "..itemstack:get_name().." replaced with "..i_rep.." x"..itemstack:get_count())					
					end
				end						
			end
		end
	end)
	

end

-- unregister flowers:waterlily
if not flowers_nt.rollback then
	minetest.unregister_item("flowers:waterlily")
end


-- Manually delete flowers:waterlily decoration as name
-- is registered as "default:waterlily" but places - "flowers:waterlily_waving"
-- other decoration names are named as == to reg node name
flowers_nt.delete_decoration({"default:waterlily"})

-- Normal registration process
flowers_nt.register_flower({
							flower_name = "Water Lily",
							grow_on     = {"default:dirt",
										   "default:water_source",
										   "default:river_water_source"
									      },
							biomes      = {"rainforest_swamp", "savanna_shore", "deciduous_forest_shore"},
							biome_seed  = 33,
							cover       = 7,
							y_max       = 0,
							y_min       = 0,
							rot_place   = true,
							light_min   = 12,
							light_max   = 15,
							time_min    = 60,
							time_max    = 180,
							drawtype    = "mesh",
							mesh        = "water_lilypad.obj",
							inv_img     = true,
							sounds      = default.node_sound_leaves_defaults(),
							color       = "pink",
							sel_box     = {-0.4,-0.5,-0.4, 0.4, -0.1, 0.4},
							existing    = "flowers:waterlily_waving",
							is_water    = {"default:dirt"}
})

