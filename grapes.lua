









local grape_base_speed = 300
local grape_retry_speed = 25




minetest.register_craftitem("farming_super:grape_leaves", {
	description = "Grape Leaves",
	inventory_image = "farming_super_grape_leaves_item.png",
	on_use = minetest.item_eat(1),
	groups = {flammable = 1},
})
--[[
minetest.register_craftitem("farming_super:grape_sapling", {
	description = "Grape Sapling",
	inventory_image = "farming_super_grape_sapling.png",
	groups = {flammable = 2},
	
	on_place = function(itemstack, placer, pointed_thing)
		local n = minetest.get_node(pointed_thing.under)
		
		if n.name == "farming:soil_wet" then
			itemstack:take_item()
			minetest.set_node(pointed_thing.under, {name = "farming_super:grape_vine", param2 = 1,})
		end
		
		return itemstack
	end,
})]]







local colors = {"red", "green", "purple", "black"}
local deco_seeds = {4673, 4674, 4675, 4676, 4677 }

for gi,color in ipairs(colors) do

	minetest.register_node("farming_super:grape_cutting_"..color, {
		description = "Grape Cutting",
		drawtype = "plantlike",
		waving = 1,
	-- 	visual_scale = 1.69,
		tiles = {"farming_super_grapes_cutting.png"},
		inventory_image = "farming_super_grapes_cutting.png",
		paramtype = "light",
		paramtype2 = "meshoptions",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = false,
		grape_color = color,
		groups = {snappy = 2, flora = 1, flammable = 1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
		},
		place_param2 = 1,
		
		on_place = function(itemstack, placer, pointed_thing)
			
			minetest.set_node(pointed_thing.above, {name="farming_super:grape_cutting_"..color, param2 = 1})
			local timer = minetest.get_node_timer(pointed_thing.above)
			timer:start(grape_base_speed)
			
			itemstack:take_item(1)
			return itemstack
		end,
		
		on_timer = function(pos, elapsed)
			local node = minetest.get_node(pos)
			local def = minetest.registered_nodes[node.name]
			local c = def.grape_color
			
			pos.y = pos.y - 1
			local soil = minetest.get_node(pos)
			if soil.name ~= "farming:desert_sand_soil_wet" then
				pos.y = pos.y + 1
-- 				print("wrong soil")
				minetest.get_node_timer(pos):start(grape_retry_speed)
				return
			end
			
			pos.y = pos.y + 1
			minetest.set_node(pos, {name = "farming_super:grape_sapling_"..color, param2 = 1})
		
			minetest.get_node_timer(pos):start(grape_base_speed)
		end,
	})

	minetest.register_node("farming_super:grape_sapling_"..color, {
		description = "Grape Sapling",
		drawtype = "plantlike",
		waving = 1,
	-- 	visual_scale = 1.69,
		tiles = {"farming_super_grapes_sapling.png"},
		inventory_image = "farming_super_grapes_sapling.png",
		paramtype = "light",
		paramtype2 = "meshoptions",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = false,
		grape_color = color,
		groups = {snappy = 2, flora = 1, flammable = 1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
		},
		place_param2 = 1,
		
		on_place = function(itemstack, placer, pointed_thing)
			
			minetest.set_node(pointed_thing.above, {name="farming_super:grape_sapling_"..color, param2 = 1})
			local timer = minetest.get_node_timer(pointed_thing.above)
			timer:start(grape_base_speed)
			
			itemstack:take_item(1)
			return itemstack
		end,
		
		on_timer = function(pos, elapsed)
			local node = minetest.get_node(pos)
			local def = minetest.registered_nodes[node.name]
			local c = def.grape_color
			
			pos.y = pos.y - 1
			local soil = minetest.get_node(pos)
			if soil.name ~= "farming:desert_sand_soil_wet" then
				pos.y = pos.y + 1
-- 				print("wrong soil")
				minetest.get_node_timer(pos):start(grape_retry_speed)
				return
			end
			
			pos.y = pos.y + 3
			local wire = minetest.get_node(pos)
			if wire.name ~= "farming_super:wire" then
				pos.y = pos.y - 2
				minetest.get_node_timer(pos):start(grape_retry_speed)
-- 				print("no wire")
				return
			end
			
			pos.y = pos.y - 1
			minetest.set_node(pos, {name = "farming_super:grape_leaves_"..color, param2 = 3})
			pos.y = pos.y - 1
			minetest.set_node(pos, {name = "farming_super:grape_stem_"..color, param2 = 1})
		end,
	})
	
	minetest.register_node("farming_super:grape_stem_"..color, {
		description = "Grape Plant",
		drawtype = "plantlike",
	-- 	waving = 1,
	-- 	visual_scale = 1.69,
		tiles = {"farming_super_grape_vine_stem.png"},
		wield_image = "farming_super_grape_vine_stem.png",
		
		paramtype = "light",
		paramtype2 = "meshoptions",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = false,
		grape_color = color,
		drop = {
			max_items = 2,
			items = {
				{ items = {'farming_super:grape_cutting_'..color}, },
				{ items = {'farming_super:grape_cutting_'..color}, rarity = 2 },
			}
		},
		groups = {snappy = 3, flora = 1, flammable = 1, grape_stem = 1, not_in_creative_inventory=1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
		},
		place_param2 = 1,
		
		after_destruct  = function(pos, oldnode)
			pos.y = pos.y + 1
			local leaves = minetest.get_node(pos)
			if minetest.get_item_group(leaves.name, "grape_leaves") > 0 then
				minetest.set_node(pos, {name="air"})
			end
		end,
	})
	
	
	minetest.register_node("farming_super:grape_leaves_"..color, {
		description = "Grape Leaves",
		drawtype = "plantlike",
		waving = 1,
		visual_scale = 1.2,
		tiles = {"default_aspen_leaves.png"},
		paramtype = "light",
		paramtype2 = "meshoptions",
		sunlight_propagates = true,
-- 		walkable = false,
		climbable = true,
		groups = {snappy=3, flora=1, flammable=1, grape_leaves=1, grape_leaves_bare=1, not_in_creative_inventory=1},
		grape_color = color,
		drop = {
			max_items = 2,
			items = {
				{ items = {'farming_super:grape_leaves 2'} },
				{ items = {'farming_super:grape_leaves 1'}, rarity = 4 },
				{ items = {'farming_super:grape_cutting_'..color}, rarity = 10 },
			}
		},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
		},
		place_param2 = 3,
	})

	minetest.register_node("farming_super:grape_yellow_leaves_"..color, {
		description = "Yellow Grape Leaves",
		drawtype = "plantlike",
		waving = 1,
		visual_scale = 1.2,
		tiles = {"default_aspen_leaves.png^[colorize:olive:150"},
		paramtype = "light",
		paramtype2 = "meshoptions",
		sunlight_propagates = true,
-- 		walkable = false,
		climbable = true,
		grape_color = color,
		groups = {snappy=3, flora=1, flammable=1, grape_leaves=1, not_in_creative_inventory=1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
		},
		collision_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
		},
		place_param2 = 3,
	})

	minetest.register_node("farming_super:grape_leaves_ripe_"..color, {
		description = "Grapes, "..color,
		drawtype = "plantlike",
		waving = 1,
		visual_scale = 1.2,
		tiles = {"default_aspen_leaves.png^farming_super_grapes_ripe_"..color..".png"},
		paramtype = "light",
		paramtype2 = "meshoptions",
		sunlight_propagates = true,
-- 		walkable = true,
		climbable = true,
		groups = {snappy=3, flora=1, flammable=1, grape_leaves=1, not_in_creative_inventory=1},
		sounds = default.node_sound_leaves_defaults(),
		drop = {
			max_items = 2,
			items = {
				{ items = {'farming_super:grape_cluster_'..color..' 2'} },
				{ items = {'farming_super:grape_cluster_'..color..' 1'}, rarity = 2},
				{ items = {'farming_super:grape_cluster_'..color..' 2'}, rarity = 6},
			}
		},
		selection_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
		},
		collision_box = {
			type = "fixed",
			fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
		},
		place_param2 = 3,
		
		after_dig_node = function(pos, oldnode, oldmetadata, digger)
			minetest.set_node(pos, {name = "farming_super:grape_leaves_"..color})
		end,
	})
	
	
	minetest.register_craftitem("farming_super:grape_cluster_"..color, {
		description = "Grapes, "..color,
-- 		inventory_image = "farming_super_grape_cluster_"..color..".png",
		inventory_image = "farming_super_grapes_ripe_"..color..".png",
		on_use = minetest.item_eat(4),
		groups = {flammable = 1},
	})
	
	
	
	minetest.register_decoration({
		name = "farming_super:grape_sapling_"..color,
		deco_type = "simple",
		place_on = {"default:desert_sand", "default:sand", "default:dry_dirt_with_dry_grass"},
		sidelen = 16,
		noise_params = {
			offset = -0.0003,
			scale = 0.0009,
			spread = {x = 200, y = 200, z = 200},
			seed = deco_seeds[gi],
			octaves = 3,
			persist = 0.6
		},
		biomes = {"desert_ocean", "savanna"},
		y_max = 30,
		y_min = 0,
		decoration = "farming_super:grape_sapling_"..color,
		param2 = 1,
	})

	
end




--[[
minetest.register_abm({
	label = "Grape wire",
	neighbors = {"farming_super:grape_2"},
	nodenames = {"farming_super:wire"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		
		local airs = minetest.find_nodes_in_area(
			{x=pos.x-1, y=pos.y-1, z=pos.z-1}, 
			{x=pos.x+1, y=pos.y-1, z=pos.z+1}, 
			{"air"})
		
		if #airs > 0 then
			local p = airs[math.random(1,#airs)]
			
			minetest.set_node(p, {name="farming_super:grape_3", param2 = 2,})
		end
	end,
})

minetest.register_abm({
	label = "Grape Vine Growth",
	nodenames = {"farming_super:grape_vine"},
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local lvl = minetest.get_node_level(pos)
		
		local cnt = math.max(1, math.ceil(((lvl - 7) / 16) ))
		
		local top = {x=pos.x, y=pos.y + cnt, z=pos.z}
		local stick = minetest.get_node(top)
		
		if stick.name == "farming_super:pole" then
			minetest.add_node_level(pos, 1)
			
		elseif stick.name == "farming_super:wire" then
				
			local airs = minetest.find_nodes_in_area(
				{x=top.x-1, y=top.y-1, z=top.z-1}, 
				{x=top.x+1, y=top.y-1, z=top.z+1}, 
				{"air"})
			
			if #airs > 0 then
				local p = airs[math.random(1,#airs)]
				
				minetest.set_node(p, {name="farming_super:grape_2", param2 = 2})
			end
		end
		
-- 		local n = minetest.get_node(pos)
-- 		print(n.param2)
-- 		minetest.set_node(pos, {name = "farming_super:grape_1", param2 = node.param2 + 1})
	end,
})

minetest.register_abm({
	label = "Grape Vine Fruit",
	nodenames = {"farming_super:grape_2"},
	interval = 1,
	chance = 5,
	action = function(pos, node)
		minetest.set_node(pos, {name = "farming_super:grape_2_fruit", param2 = 2})
	end,
})

]]


minetest.register_abm({
	label = "Grape Vine Leaf Regrowth",
	nodenames = {"group:grape_stem"},
	interval = grape_base_speed / 10,
	chance = 20,
	action = function(pos, node)
		pos.y = pos.y + 1
		
		local n = minetest.get_node(pos)
		if n.name == "air" then
			
			local color = minetest.registered_nodes[node.name].grape_color
			minetest.set_node(pos, {name = "farming_super:grape_leaves_"..color, param2 = 3})
		end
	end,
})


minetest.register_abm({
	label = "Grape Vine Fruit",
	nodenames = {"group:grape_leaves_bare"},
	interval = grape_base_speed / 10,
	chance = 30,
	action = function(pos, node)
		local color = minetest.registered_nodes[node.name].grape_color
		minetest.set_node(pos, {name = "farming_super:grape_leaves_ripe_"..color, param2 = 3})
	end,
})
