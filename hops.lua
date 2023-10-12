









local base_speed = 100




minetest.register_craftitem("farming_super:hops", {
	description = "Hops",
	inventory_image = "farming_super_hops.png",
	groups = {flammable = 2},
})

minetest.register_craftitem("farming_super:hops_sapling", {
	description = "Hops Sapling",
	inventory_image = "farming_super_hops_vine.png",
	groups = {flammable = 2},
	
	on_place = function(itemstack, placer, pointed_thing)
		local n = minetest.get_node(pointed_thing.under)
		
		if n.name == "farming:soil_wet" then
			itemstack:take_item()
			minetest.set_node(pointed_thing.under, {name = "farming_super:hops_vine", param2 = 1,})
		end
		
		return itemstack
	end,
})


minetest.register_node("farming_super:hops_vine", {
	description = "Hops Plant",
	drawtype = "plantlike_rooted",
	waving = 1,
	tiles = {"default_dirt.png^farming_soil_wet.png", "default_dirt.png^farming_soil_wet_side.png"},
	drop = "default:dirt",
	special_tiles = {{name = "farming_super_hops_vine.png", tileable_vertical = true}},
	inventory_image = "farming_super_hops_vine.png",
	paramtype = "light",
	paramtype2 = "leveled",
	place_param2 = 1,
	groups = {snappy = 3},
	visual_scale = 1.5,
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
-- 		if n.name == "farming_super:hops_vine_fruit" then 
-- 			minetest.set_node(pos, {name = "farming_super:hops_vine", param2 = oldnode.param2})
		if n.name ~= "farming_super:hops_vine_fruit" then 
			minetest.set_node(pos, {name = "farming:soil_wet"})
		end
	end,
})


minetest.register_decoration({
	name = "farming_super:hops_vine",
	deco_type = "simple",
	place_on = {"default:dirt_with_coniferous_litter"},
	sidelen = 16,
	noise_params = {
		offset = -0.002,
		scale = 0.03,
		spread = {x = 200, y = 200, z = 200},
		seed = 56784,
		octaves = 3,
		persist = 0.8
	},
	biomes = {"coniferous_forest"},
	y_max = 140,
	y_min = 20,
	decoration = "farming_super:hops_vine",
	--decoration = "default:mese_block",
})


minetest.register_node("farming_super:hops_vine_fruit", {
	description = "Hops Plant with Flowers",
	drawtype = "plantlike_rooted",
	waving = 1,
	tiles = {"default_sand.png"},
	tiles = {"default_dirt.png^farming_soil_wet.png", "default_dirt.png^farming_soil_wet_side.png"},
	drop = "default:dirt",
	special_tiles = {{name = "farming_super_hops_vine_fruit.png", tileable_vertical = true}},
	inventory_image = "farming_super_hops_vine_fruit.png",
	paramtype = "light",
	paramtype2 = "leveled",
	place_param2 = 1,
	groups = {snappy = 3},
	visual_scale = 1.5,
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
-- 		if n.name == "farming_super:hops_vine_fruit" then 
-- 			minetest.set_node(pos, {name = "farming_super:hops_vine", param2 = oldnode.param2})
		if n.name ~= "farming_super:hops_vine_fruit" then 
			minetest.set_node(pos, {name = "farming:soil_wet"})
		end
	end,
})



minetest.register_abm({
	label = "Hops Vine Growth",
	nodenames = {"farming_super:hops_vine", "farming_super:hops_vine_fruit", },
	interval = 1,
	chance = 1,
	action = function(pos, node)
		local lvl = minetest.get_node_level(pos)
		
		local cnt = math.max(1, math.ceil(((lvl - 7) / 16) * 1.5) )
		
		local top = {x=pos.x, y=pos.y + cnt, z=pos.z}
		local stick = minetest.get_node(top)
		
		if stick.name == "farming_super:pole" then
			minetest.add_node_level(pos, 1)
		end
		
	end,
})


minetest.register_abm({
	label = "Hops Vine Fruit Growth",
	nodenames = {"farming_super:hops_vine", },
	interval = 5,
	chance = 1,
	action = function(pos, node)
		minetest.set_node(pos, {name="farming_super:hops_vine_fruit", param2 = node.param2})
	end,
})

