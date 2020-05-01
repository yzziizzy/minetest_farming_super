



--[[
TODO:

tension physics on wires
spots/bugs disease
check nearby nodes for yellowing decision
growth and aging of vines


]]


local grape_speed = {
	rand = 60,
	retry = 30,
	cutting = 1600,
	sapling = 2800,
	fruit = 1000,
	leaf_regrowth = 40,
	wine = 60*60*2,
}
--[[

local grape_speed = {
	retry = 2,
	cutting = 6,
	sapling = 6,
	fruit = 4,
	leaf_regrowth = 4,
}
]]


local function gr() 
	return math.random(grape_speed.rand)
end


minetest.register_craftitem("farming_super:grape_leaves", {
	description = "Grape Leaves",
	inventory_image = "farming_super_grapes_leaves_item.png",
	on_use = minetest.item_eat(1),
	groups = {flammable = 1},
})





local colors = {"red", "green", "purple", "black"}
local deco_seeds = {4673, 4674, 4675, 4676, 4677 }

for gi,color in ipairs(colors) do

	minetest.register_node("farming_super:grape_cutting_"..color, {
		description = "Grape Cutting",
		drawtype = "plantlike",
-- 		waving = 1,
	-- 	visual_scale = 1.69,
		tiles = {"farming_super_grapes_cutting.png"},
		inventory_image = "farming_super_grapes_cutting.png",
		paramtype = "light",
		paramtype2 = "meshoptions",
		sunlight_propagates = true,
		walkable = false,
		buildable_to = false,
		grape_color = color,
		groups = {snappy = 2, oddly_breakable_by_hand = 2, flammable = 1, grape_cutting=1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16},
		},
		place_param2 = 1,
		
		on_place = function(itemstack, placer, pointed_thing)
			
			minetest.set_node(pointed_thing.above, {name="farming_super:grape_cutting_"..color, param2 = 1})
			local timer = minetest.get_node_timer(pointed_thing.above)
			timer:start(grape_speed.cutting + gr())
			
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
				minetest.get_node_timer(pos):start(grape_speed.retry)
				return
			end
			
			pos.y = pos.y + 1
			minetest.set_node(pos, {name = "farming_super:grape_sapling_"..color, param2 = 1})
		
			minetest.get_node_timer(pos):start(grape_speed.sapling + gr())
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
		groups = {snappy = 2, oddly_breakable_by_hand = 2, flammable = 1, grape_sapling=1},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0.5, 5 / 16},
		},
		place_param2 = 1,
		
		on_place = function(itemstack, placer, pointed_thing)
			
			minetest.set_node(pointed_thing.above, {name="farming_super:grape_sapling_"..color, param2 = 1})
			local timer = minetest.get_node_timer(pointed_thing.above)
			timer:start(grape_speed.sapling + gr())
			
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
				minetest.get_node_timer(pos):start(grape_speed.retry)
				return
			end
			
			pos.y = pos.y + 3
			local wire = minetest.get_node(pos)
			if wire.name ~= "farming_super:wire" then
				pos.y = pos.y - 2
				minetest.get_node_timer(pos):start(grape_speed.retry)
-- 				print("no wire")
				return
			end
			
			pos.y = pos.y - 1
			minetest.set_node(pos, {name = "farming_super:grape_leaves_"..color, param2 = 3})
			minetest.get_node_timer(pos):start(grape_speed.fruit + gr())
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
		groups = {
			snappy = 1, choppy=2, flammable = 1, grape_stem = 1, not_in_creative_inventory=1,
		},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-3 / 16, -0.5, -3 / 16, 3 / 16, 0.5, 3 / 16},
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
		groups = {
			snappy=1, flammable=1, grape_leaves=1, grape_leaves_bare=1, 
			grape_healthy_leaves=1, not_in_creative_inventory=1, hangs_from_vines=1, 
		},
		grape_color = color,
		drop = {
			max_items = 2,
			items = {
				{ items = {'farming_super:grape_leaves 1'} },
				{ items = {'farming_super:grape_leaves 1'}, rarity = 4 },
				{ items = {'farming_super:grape_cutting_'..color}, rarity = 10 },
			}
		},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0.5, 5 / 16},
		},
		collision_box = {
			type = "fixed",
			fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0.5, 5 / 16},
		},
		place_param2 = 3,
		
		on_timer = function(pos, elapsed)
			local node = minetest.get_node(pos)
			local color = minetest.registered_nodes[node.name].grape_color
			minetest.set_node(pos, {name = "farming_super:grape_leaves_ripe_"..color, param2 = 3})

			minetest.get_node_timer(pos):start(grape_speed.fruit + gr())
		end,
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
		groups = {
			snappy=1, flammable=1, grape_leaves=1, grape_yellow_leaves=1, 
			not_in_creative_inventory=1, hangs_from_vines=1 
		},
		sounds = default.node_sound_leaves_defaults(),
		selection_box = {
			type = "fixed",
			fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0.5, 5 / 16},
		},
		collision_box = {
			type = "fixed",
			fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0.5, 5 / 16},
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
		grape_color = color,
		groups = {
			snappy=1, flammable=1, grape_leaves=1, grape_healthy_leaves=1, 
			not_in_creative_inventory=1, hangs_from_vines=1 
		},
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
			fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0.5, 5 / 16},
		},
		collision_box = {
			type = "fixed",
			fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0.5, 5 / 16},
		},
		place_param2 = 3,
		
-- 		after_dig_node = function(pos, oldnode, oldmetadata, digger)
-- 			minetest.set_node(pos, {name = "farming_super:grape_leaves_"..color})
-- 		end,
		
		on_punch = function(pos, node, puncher)
			local inv = puncher:get_inventory()
			
			local drops = minetest.get_node_drops(node.name)
			for _,d in pairs(drops) do
				inv:add_item("main", d)
			end
			
			minetest.set_node(pos, {name = "farming_super:grape_leaves_"..color, param2 = 3})
			minetest.get_node_timer(pos):start(grape_speed.fruit + gr())
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
	
	
	
	-- grape products and crafts
	minetest.register_craftitem("farming_super:grape_juice_"..color, {
		description = "Grape Juice, "..color,
		inventory_image = "farming_super_grapes_juice_"..color..".png",
		on_use = minetest.item_eat(7, "vessels:glass_bottle"),
		groups = {flammable = 1},
	})

	local bunch = "farming_super:grape_cluster_"..color
	local juice = "farming_super:grape_juice_"..color
	minetest.register_craft({
		output = "farming_super:grape_juice_"..color,
		recipe = {
			{bunch, bunch, bunch},
			{bunch, "vessels:glass_bottle", bunch},
			{bunch, bunch, bunch},
		},
	})
	
	
	minetest.register_node("farming_super:grape_juice_barrel_"..color, {
		description = "Juice Barrel, "..color,
		tiles = {
			"default_wood.png^farming_super_barrel_bung.png", 
			"default_wood.png", 
			"default_wood.png^[transformR90^farming_super_barrel_rings.png",
			"default_wood.png^[transformR90^farming_super_barrel_rings.png", 
			"default_wood.png^[transformR90^farming_super_barrel_rings.png", 
			"default_wood.png^[transformR90^farming_super_barrel_rings.png"
		},
		paramtype2 = "facedir",
		-- inventory_image = "bitumen_oil_drum.png",
		groups = {
			cracky=2,
			choppy=2,
			oddly_breakable_by_hand=2,
		},
		paramtype = "light",
		drawtype = "nodebox",
		grape_color = color,
		node_box = {
			type = "fixed",
			fixed = {
				--11.25
				{-0.49, -0.5, -0.10, 0.49, 0.5, 0.10},
				{-0.10, -0.5, -0.49, 0.10, 0.5, 0.49},
				--22.5
				{-0.46, -0.5, -0.19, 0.46, 0.5, 0.19},
				{-0.19, -0.5, -0.46, 0.19, 0.5, 0.46},
				-- 33.75
				{-0.416, -0.5, -0.28, 0.416, 0.5, 0.28},
				{-0.28, -0.5, -0.416, 0.28, 0.5, 0.416},
				--45
				{-0.35, -0.5, -0.35, 0.35, 0.5, 0.35},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			},
		},
		on_place = function(itemstack, placer, pointed_thing)
			minetest.set_node(pointed_thing.above, {name = "farming_super:grape_juice_barrel_"..color})
			
			local timer = minetest.get_node_timer(pointed_thing.above)
			timer:start(grape_speed.wine)
			
			itemstack:take_item(1)
			return itemstack
		end,
		
		on_timer = function(pos, elapsed)
			local node = minetest.get_node(pos)
			local color = minetest.registered_nodes[node.name].grape_color
			minetest.set_node(pos, {name = "farming_super:wine_barrel_"..color})
		end,
	})
	
	minetest.register_node("farming_super:wine_barrel_"..color, {
		description = "Wine Barrel, "..color,
		tiles = {
			"default_wood.png^farming_super_barrel_bung.png", 
			"default_wood.png", 
			"default_wood.png^[transformR90^farming_super_barrel_rings.png",
			"default_wood.png^[transformR90^farming_super_barrel_rings.png", 
			"default_wood.png^[transformR90^farming_super_barrel_rings.png", 
			"default_wood.png^[transformR90^farming_super_barrel_rings.png"
		},
		paramtype2 = "facedir",
		-- inventory_image = "bitumen_oil_drum.png",
		groups = {
			cracky=2,
			choppy=2,
			oddly_breakable_by_hand=2,
		},
		paramtype = "light",
		drawtype = "nodebox",
		grape_color = color,
		node_box = {
			type = "fixed",
			fixed = {
				--11.25
				{-0.49, -0.5, -0.10, 0.49, 0.5, 0.10},
				{-0.10, -0.5, -0.49, 0.10, 0.5, 0.49},
				--22.5
				{-0.46, -0.5, -0.19, 0.46, 0.5, 0.19},
				{-0.19, -0.5, -0.46, 0.19, 0.5, 0.46},
				-- 33.75
				{-0.416, -0.5, -0.28, 0.416, 0.5, 0.28},
				{-0.28, -0.5, -0.416, 0.28, 0.5, 0.416},
				--45
				{-0.35, -0.5, -0.35, 0.35, 0.5, 0.35},
			},
		},
		selection_box = {
			type = "fixed",
			fixed = {
				{-0.5, -0.5, -0.5, 0.5, 0.5, 0.5},
			},
		},
		stack_max = 1,
	})
	
	minetest.register_craft({
		output = "farming_super:grape_juice_barrel_"..color,
		recipe = {
			{juice, juice, juice},
			{juice, "farming_super:barrel", juice},
			{juice, juice, juice},
		},
	})
	
end





minetest.register_abm({
	label = "Grape Vine Leaf Regrowth",
	nodenames = {"group:grape_stem"},
	interval = grape_speed.leaf_regrowth,
	chance = 20,
	action = function(pos, node)
		pos.y = pos.y + 1
		
		local n = minetest.get_node(pos)
		if n.name == "air" then
			
			local color = minetest.registered_nodes[node.name].grape_color
			minetest.set_node(pos, {name = "farming_super:grape_leaves_"..color, param2 = 3})
			minetest.get_node_timer(pos):start(grape_speed.fruit + gr())
		end
	end,
})


minetest.register_abm({
	label = "Grape Vine Fruit",
	nodenames = {"group:grape_leaves_bare"},
	interval = 10,
	chance = 10,
	action = function(pos, node)
		local timer = minetest.get_node_timer(pos)
		if not timer:is_started() then
			timer:start(grape_speed.fruit + gr())
		end
		
	end,
})

minetest.register_abm({
	label = "Grape Vine Fruit",
	nodenames = {"group:grape_stem", "group:grape_cutting", "group:grape_sapling"},
	interval = 30,
	chance = 5,
	action = function(pos, node)
		local timer = minetest.get_node_timer(pos)
		if not timer:is_started() then
			timer:start(grape_speed.fruit + gr())
		end
		
	end,
})


minetest.register_abm({
	label = "Grape Leaf Disease Origin",
	nodenames = {"group:grape_healthy_leaves"},
	interval = 440,
	chance = 900,
	action = function(pos)
		local node = minetest.get_node(pos)
		local color = minetest.registered_nodes[node.name].grape_color
		minetest.set_node(pos, {name = "farming_super:grape_yellow_leaves_"..color, param2 = 3})
		minetest.get_node_timer(pos):start(grape_speed.fruit + gr())
	end,
})

minetest.register_abm({
	label = "Grape Leaf Disease Spread",
	nodenames = {"group:grape_yellow_leaves"},
	neighbors = {"group:grape_healthy_leaves"},
	interval = 20,
	chance = 30,
	action = function(pos)
		local node = minetest.get_node(pos)
		local color = minetest.registered_nodes[node.name].grape_color
		minetest.set_node(pos, {name = "farming_super:grape_yellow_leaves_"..color, param2 = 3})
		minetest.get_node_timer(pos):start(grape_speed.fruit + gr())
	end,
})













