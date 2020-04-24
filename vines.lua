









local base_speed = 100




minetest.register_craftitem("farming_super:kiwi", {
	description = "Kiwi",
	inventory_image = "farming_super_kiwi.png",
	on_use = minetest.item_eat(2),
	groups = {flammable = 2},
})

minetest.register_craftitem("farming_super:kiwi_sapling", {
	description = "Kiwi Sapling",
	inventory_image = "farming_super_kiwi_vine.png",
	groups = {flammable = 2},
	
	on_place = function(itemstack, placer, pointed_thing)
		local n = minetest.get_node(pointed_thing.under)
		
		if n.name == "farming:soil_wet" then
			itemstack:take_item()
			minetest.set_node(pointed_thing.under, {name = "farming_super:kiwi_vine", param2 = 1,})
		end
		
		return itemstack
	end,
})



minetest.register_node("farming_super:kiwi_2", {
	description = "Kiwi Plant",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.69,
	tiles = {"farming_super_kiwi_vine_1.png"},
	wield_image = "farming_super_kiwi_vine_1.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	place_param2 = 2,
})

minetest.register_node("farming_super:kiwi_3", {
	description = "Kiwi Plant",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.2,
	tiles = {"farming_super_kiwi_vine_1.png"},
	wield_image = "farming_super_kiwi_vine_1.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	place_param2 = 2,
})

minetest.register_node("farming_super:kiwi_2_fruit", {
	description = "Ripe Kiwi Plant",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.69,
	tiles = {"farming_super_kiwi_vine_with_fruit.png"},
	wield_image = "farming_super_kiwi_vine_with_fruit.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	drop = {
		max_items = 2,
		items = {
			{items = {"farming_super:kiwi_sapling"}, rarity = 10},
			{items = {"farming_super:kiwi 2"}},
			{items = {"farming_super:kiwi 3"}},
		},
	},
	place_param2 = 2,
	after_destruct  = function(pos)
		minetest.set_node(pos, {name = "farming_super:kiwi_2"})
	end,
})

minetest.register_node("farming_super:kiwi_3_fruit", {
	description = "Ripe Kiwi Plant",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.2,
	tiles = {"farming_super_kiwi_vine_with_fruit.png"},
	wield_image = "farming_super_kiwi_vine_with_fruit.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = true,
	groups = {snappy = 3, flora = 1, flammable = 1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 0.5, 6 / 16},
	},
	drop = {
		max_items = 2,
		items = {
			{items = {"farming_super:kiwi_sapling"}, rarity = 10},
			{items = {"farming_super:kiwi 2"}},
			{items = {"farming_super:kiwi 3"}},
		},
	},
	place_param2 = 2,
	after_destruct  = function(pos)
		minetest.set_node(pos, {name = "farming_super:kiwi_3"})
	end,
})



minetest.register_node("farming_super:kiwi_vine", {
	description = "Kiwi Plant",
	drawtype = "plantlike_rooted",
	waving = 1,
	tiles = {"default_sand.png"},
	tiles = {"default_dirt.png^farming_soil_wet.png", "default_dirt.png^farming_soil_wet_side.png"},
	drop = "default:dirt",
	special_tiles = {{name = "farming_super_kiwi_vine.png", tileable_vertical = true}},
	inventory_image = "farming_super_kiwi_vine.png",
	paramtype = "light",
	paramtype2 = "leveled",
	place_param2 = 1,
	groups = {snappy = 3},
	selection_box = {
		type = "fixed",
		fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
				{-2/16, 0.5, -2/16, 2/16, 3.5, 2/16},
		},
	},
	node_dig_prediction = "default:sand",
	node_placement_prediction = "",
	sounds = default.node_sound_sand_defaults({
		dig = {name = "default_dig_snappy", gain = 0.2},
		dug = {name = "default_grass_footstep", gain = 0.25},
	}),
	


	after_destruct  = function(pos, oldnode)
		local n = minetest.get_node(pos)
		if n.name ~= "farming_super:kiwi_vine" then 
			minetest.set_node(pos, {name = "farming:soil_wet"})
		end
	end
})


minetest.register_abm({
	label = "Kiwi wire",
	neighbors = {"farming_super:kiwi_2"},
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
			
			minetest.set_node(p, {name="farming_super:kiwi_3", param2 = 2,})
		end
	end,
})

minetest.register_abm({
	label = "Kiwi Vine Growth",
	nodenames = {"farming_super:kiwi_vine"},
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
				
				minetest.set_node(p, {name="farming_super:kiwi_2", param2 = 2})
			end
		end
		
-- 		local n = minetest.get_node(pos)
-- 		print(n.param2)
-- 		minetest.set_node(pos, {name = "farming_super:kiwi_1", param2 = node.param2 + 1})
	end,
})

minetest.register_abm({
	label = "Kiwi Vine Fruit",
	nodenames = {"farming_super:kiwi_2"},
	interval = 1,
	chance = 5,
	action = function(pos, node)
		minetest.set_node(pos, {name = "farming_super:kiwi_2_fruit", param2 = 2})
	end,
})
minetest.register_abm({
	label = "Kiwi Vine Fruit",
	nodenames = {"farming_super:kiwi_3"},
	interval = 1,
	chance = 5,
	action = function(pos, node)
		minetest.set_node(pos, {name = "farming_super:kiwi_3_fruit", param2 = 2})
	end,
})

