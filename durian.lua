


local durian_speed = {
	sapling = 500,
	rand = 60,
}

local function gr()
	return math.random(durian_speed.rand)
end

minetest.register_node("farming_super:jackfruit", {
	description = "Jackfruit",
	tiles = {"default_cactus_side.png"},
	paramtype = "light",
	drawtype = "nodebox",
	
	node_box = {
		type = "connected",
		disconnected = {
			{-0.03, 0-.2, -0.03, 0.03, .45-.2, 0.03},
			{-0.15, -.3-.2, -0.15, 0.15, .3-.2, 0.15},
			{-0.20, -.22-.2, -0.20, 0.20, .22-.2, 0.20},
		},
		connect_top = {
			{-0.03, 0, -0.03, 0.03, .5, 0.03},
			{-0.15, -.3, -0.15, 0.15, .3, 0.15},
			{-0.20, -.22, -0.20, 0.20, .22, 0.20},
		},
		connect_right = {
			{-0.03+.2, .3, -0.03, 0.03+.2, .4, 0.03},
			{-0.03+.2, .4-0.03, -0.03, 0.5, .4+0.03, 0.03},
			{-0.15+.2, -.3, -0.15, 0.15+.2, .3, 0.15},
			{-0.20+.2, -.22, -0.20, 0.20+.2, .22, 0.20},
		},
		connect_left = {
			{-0.03-.2, 0, -0.03,    0.03-.2, .4, 0.03},
			{-0.5, .4-0.03, -0.03,  0.03-.2, .4+0.03, 0.03},
			{-0.15-.2, -.3, -0.15,  0.15-.2, .3, 0.15},
			{-0.20-.2, -.22, -0.20, 0.20-.2, .22, 0.20},
		},
		connect_front = {
			{-0.03, 0, -0.03-.2, 0.03, .4, 0.03-.2},
			{-0.03, .4-0.03, -0.5, 0.03, .4+0.03, 0.03-.2},
			{-0.15, -.3, -0.15-.2, 0.15, .3, 0.15-.2},
			{-0.20, -.22, -0.20-.2, 0.20, .22, 0.20-.2},
		},
		connect_back = {
			{-0.03, 0, -0.03+.2, 0.03, .4, 0.03+.2},
			{-0.03, .4-0.03, -0.03+.2, 0.03, .4+0.03, 0.5},
			{-0.15, -.3, -0.15+.2, 0.15, .3, 0.15+.2},
			{-0.20, -.22, -0.20+.2, 0.20, .22, 0.20+.2},
		},
	},
	collision_box = {
		type = "connected",
		disconnected = {{-0.20, -.3-.2, -0.20, 0.20, .43-.2, 0.20},},
		connect_top = {{-0.20, -.3, -0.20, 0.20, .43, 0.20},},
		connect_right = {{-0.20+.2, -.3, -0.20, 0.20+.2, .43, 0.20},},
		connect_left = {{-0.20-.2, -.3, -0.20, 0.20-.2, .43, 0.20},},
		connect_front = {{-0.20, -.3, -0.20-.2, 0.20, .43, 0.20-.2},},
		connect_back = {{-0.20, -.3, -0.20+.2, 0.20, .43, 0.20+.2},},
	},
	selection_box = {
		type = "connected",
		disconnected = {{-0.20, -.3-.2, -0.20, 0.20, .43-.2, 0.20},},
		connect_top = {{-0.20, -.3, -0.20, 0.20, .43, 0.20},},
		connect_right = {{-0.20+.2, -.3, -0.20, 0.20+.2, .43, 0.20},},
		connect_left = {{-0.20-.2, -.3, -0.20, 0.20-.2, .43, 0.20},},
		connect_front = {{-0.20, -.3, -0.20-.2, 0.20, .43, 0.20-.2},},
		connect_back = {{-0.20, -.3, -0.20+.2, 0.20, .43, 0.20+.2},},
	},
	connects_to = {"group:tree"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 2, plant = 1},
	sounds = default.node_sound_wood_defaults(),
})



--[[
minetest.register_node("farming_super:durian", {
	description = "Durian",
	tiles = {"default_cactus_side.png"},
	paramtype = "light",
	drawtype = "nodebox",
	
	node_box = {
		type = "connected",
		disconnected = {
			{-0.03*.7, (0-.2)*.7,    -0.03*.7, 0.03*.7, (.45-.2)*.7, 0.03*.7},
			{-0.15*.7, (-.3-.2)*.7,  -0.15*.7, 0.15*.7, (.3-.2)*.7,  0.15*.7},
			{-0.20*.7, (-.22-.2)*.7, -0.20*.7, 0.20*.7, (.22-.2)*.7, 0.20*.7},
		},
		connect_top = {
			{-0.03*.7, 0,       -0.03*.7, 0.03*.7, .5,     0.03*.7},
			{-0.15*.7, -.3*.7,  -0.15*.7, 0.15*.7, .3*.7,  0.15*.7},
			{-0.20*.7, -.22*.7, -0.20*.7, 0.20*.7, .22*.7, 0.20*.7},
		},
		connect_right = {
			{(-0.03+.3)*.7, (.3)*.7,      (-0.03)*.7, (0.03+.3)*.7, (.4)*.7,      (0.03)*.7},
			{(-0.03+.3)*.7, (.4-0.03)*.7, (-0.03)*.7, (0.5),        (.4+0.03)*.7, (0.03)*.7},
			{(-0.15+.3)*.7, (-.3)*.7,     (-0.15)*.7, (0.15+.3)*.7, (.3)*.7,      (0.15)*.7},
			{(-0.20+.3)*.7, (-.22)*.7,    (-0.20)*.7, (0.20+.3)*.7, (.22)*.7,     (0.20)*.7},
		},
		connect_left = {
			{(-0.03-.3)*.7, (0)*.7,       (-0.03)*.7, (0.03-.3)*.7, (.4)*.7,      (0.03)*.7},
			{(-0.5),        (.4-0.03)*.7, (-0.03)*.7, (0.03-.3)*.7, (.4+0.03)*.7, (0.03)*.7},
			{(-0.15-.3)*.7, (-.3)*.7,     (-0.15)*.7, (0.15-.3)*.7, (.3)*.7,      (0.15)*.7},
			{(-0.20-.3)*.7, (-.22)*.7,    (-0.20)*.7, (0.20-.3)*.7, (.22)*.7,     (0.20)*.7},
		},
		connect_front = {
			{(-0.03)*.7, (0)*.7,       (-0.03-.3)*.7, (0.03)*.7, (.4)*.7,      (0.03-.3)*.7},
			{(-0.03)*.7, (.4-0.03)*.7, (-0.5),        (0.03)*.7, (.4+0.03)*.7, (0.03-.3)*.7},
			{(-0.15)*.7, (-.3)*.7,     (-0.15-.3)*.7, (0.15)*.7, (.3)*.7,      (0.15-.3)*.7},
			{(-0.20)*.7, (-.22)*.7,    (-0.20-.3)*.7, (0.20)*.7, (.22)*.7,     (0.20-.3)*.7},
		},
		connect_back = {
			{(-0.03)*.7, (0)*.7,       (-0.03+.3)*.7, (0.03)*.7, (.4)*.7,      (0.03+.3)*.7},
			{(-0.03)*.7, (.4-0.03)*.7, (-0.03+.3)*.7, (0.03)*.7, (.4+0.03)*.7, (0.5)},
			{(-0.15)*.7, (-.3)*.7,     (-0.15+.3)*.7, (0.15)*.7, (.3)*.7,      (0.15+.3)*.7},
			{(-0.20)*.7, (-.22)*.7,    (-0.20+.3)*.7, (0.20)*.7, (.22)*.7,     (0.20+.3)*.7},
		},
	},
	collision_box = {
		type = "connected",
		disconnected = {{-0.20*.7, (-.3-.2)*.7, -0.20*.7, 0.20*.7, (.43-.2)*.7, 0.20*.7},},
		connect_top = {{-0.20*.7, -.3*.7, -0.20*.7, 0.20*.7, .43*.7, 0.20*.7},},
		connect_right = {{(-0.20+.3)*.7, (-.3)*.7, (-0.20)*.7, (0.20+.3)*.7, (.43)*.7, (0.20)*.7},},
		connect_left = {{(-0.20-.3)*.7, (-.3)*.7, (-0.20)*.7, (0.20-.3)*.7, (.43)*.7, (0.20)*.7},},
		connect_front = {{(-0.20)*.7, (-.3)*.7, (-0.20-.3)*.7, (0.20)*.7, (.43)*.7, (0.20-.3)*.7},},
		connect_back = {{(-0.20)*.7, (-.3)*.7, (-0.20+.3)*.7, (0.20)*.7, (.43)*.7, (0.20+.3)*.7},},
	},
	selection_box = {
		type = "connected",
		disconnected = {{-0.20*.7, (-.3-.2)*.7, -0.20*.7, 0.20*.7, (.43-.2)*.7, 0.20*.7},},
		connect_top = {{-0.20*.7, -.3*.7, -0.20*.7, 0.20*.7, .43*.7, 0.20*.7},},
		connect_right = {{(-0.20+.3)*.7, (-.3)*.7, (-0.20)*.7, (0.20+.3)*.7, (.43)*.7, (0.20)*.7},},
		connect_left = {{(-0.20-.3)*.7, (-.3)*.7, (-0.20)*.7, (0.20-.3)*.7, (.43)*.7, (0.20)*.7},},
		connect_front = {{(-0.20)*.7, (-.3)*.7, (-0.20-.3)*.7, (0.20)*.7, (.43)*.7, (0.20-.3)*.7},},
		connect_back = {{(-0.20)*.7, (-.3)*.7, (-0.20+.3)*.7, (0.20)*.7, (.43)*.7, (0.20+.3)*.7},},
	},
	connects_to = {"group:tree"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 2, plant = 1},
	sounds = default.node_sound_wood_defaults(),
})
]]

minetest.register_node("farming_super:durian", {
	description = "Durian",
	tiles = {"default_cactus_side.png"},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.03*.7, (0-.2)*.7,    -0.03*.7, 0.03*.7, (.45-.2)*.7, 0.03*.7},
			{-0.15*.7, (-.3-.2)*.7,  -0.15*.7, 0.15*.7, (.3-.2)*.7,  0.15*.7},
			{-0.20*.7, (-.22-.2)*.7, -0.20*.7, 0.20*.7, (.22-.2)*.7, 0.20*.7},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {{-0.20*.7, (-.3-.2)*.7, -0.20*.7, 0.20*.7, (.43-.2)*.7, 0.20*.7},},
	},
	selection_box = {
		type = "fixed",
		fixed = {{-0.20*.7, (-.3-.2)*.7, -0.20*.7, 0.20*.7, (.43-.2)*.7, 0.20*.7},},
	},
	connects_to = {"group:tree"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 2, plant = 1},
	sounds = default.node_sound_wood_defaults(),
})



minetest.register_node("farming_super:durian_top", {
	description = "Durian",
	tiles = {"default_cactus_side.png"},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{-0.03*.7, 0,       -0.03*.7, 0.03*.7, .5,     0.03*.7},
			{-0.15*.7, -.3*.7,  -0.15*.7, 0.15*.7, .3*.7,  0.15*.7},
			{-0.20*.7, -.22*.7, -0.20*.7, 0.20*.7, .22*.7, 0.20*.7},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {{-0.20*.7, -.3*.7, -0.20*.7, 0.20*.7, .43*.7, 0.20*.7},},
	},
	selection_box = {
		type = "fixed",
		connect_top = {{-0.20*.7, -.3*.7, -0.20*.7, 0.20*.7, .43*.7, 0.20*.7},},
	},
	drop = "farming_super:durian",
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 2, plant = 1, durian_fruit=1},
	sounds = default.node_sound_wood_defaults(),
})



minetest.register_node("farming_super:durian_side", {
	description = "Durian",
	tiles = {"default_cactus_side.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	drawtype = "nodebox",
	node_box = {
		type = "fixed",
		fixed = {
			{(-0.03)*.7, (0)*.7,       (-0.03-.3)*.7, (0.03)*.7, (.4)*.7,      (0.03-.3)*.7},
			{(-0.03)*.7, (.4-0.03)*.7, (-0.5),        (0.03)*.7, (.4+0.03)*.7, (0.03-.3)*.7},
			{(-0.15)*.7, (-.3)*.7,     (-0.15-.3)*.7, (0.15)*.7, (.3)*.7,      (0.15-.3)*.7},
			{(-0.20)*.7, (-.22)*.7,    (-0.20-.3)*.7, (0.20)*.7, (.22)*.7,     (0.20-.3)*.7},
		},
	},
	collision_box = {
		type = "fixed",
		fixed = {{(-0.20)*.7, (-.3)*.7, (-0.20-.3)*.7, (0.20)*.7, (.43)*.7, (0.20-.3)*.7},},
	},
	selection_box = {
		type = "fixed",
		fixed = {{(-0.20)*.7, (-.3)*.7, (-0.20-.3)*.7, (0.20)*.7, (.43)*.7, (0.20-.3)*.7},},
	},
	drop = "farming_super:durian",
	connects_to = {"group:tree"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 2, plant = 1, durian_fruit=1},
	sounds = default.node_sound_wood_defaults(),
})



minetest.register_node("farming_super:durian_tree", {
	description = "Durian Tree",
	tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	paramtype = "light",
	paramtype2 = "facedir",
	is_ground_content = false,
	drop = "default:tree",
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = minetest.rotate_node,
	after_destruct = function(pos)
		local durians = minetest.find_nodes_in_area(
			vector.subtract(pos, {x=-1, y=-1, z=-1}),
			vector.subtract(pos, {x=1, y=0, z=1}),
			"group:durian_fruit"
		)
		
		for _,p in ipairs(durians) do
			minetest.set_node(p, {name="air"})
			minetest.add_item(p, {name="farming_super:durian"})
		end
		
	end,
})



minetest.register_node("farming_super:durian_leaves", {
	description = "Durian Leaves",
	drawtype = "allfaces_optional",
	tiles = {"default_acacia_leaves.png"},
	special_tiles = {"default_acacia_leaves_simple.png"},
	waving = 1,
	paramtype = "light",
	is_ground_content = false,
	groups = {snappy = 3, leafdecay = 3, flammable = 2, leaves = 1},
	sounds = default.node_sound_leaves_defaults(),
})

local function not_air(pos)
	local n = minetest.get_node(pos)
	if n.name == "air" then
		return false
	end
	if minetest.registered_nodes[n.name].buildable_to then
		return false
	end
	return true
end


local function durian_tree(pos, nodes)
	local oy = pos.y
	
	minetest.set_node(pos, {name=nodes.tree})
	
	for j = 1,4 do
		pos.y = pos.y + 1
		
		if not_air(pos) then
			return
		end
		
		minetest.set_node(pos, {name=nodes.tree})
	end
	
	local dirs = {
		{x=1, y=0,z=0},
		{x=0, y=0,z=1},
		{x=-1,y=0,z=0},
		{x=0, y=0,z=-1},
	}
	local fdirs = {12, 8, 12, 8}
	
	local function branch(pos)
		local rd = math.random(#dirs)
		local dir = dirs[rd]
		local d = vector.add(pos, dir)
		local r = math.random(1, 4)
		
		for i=1,r do
			if not_air(d) then
				return
			end
			minetest.set_node(d, {
				name = nodes.tree,
				param2 = fdirs[rd] --minetest.dir_to_facedir(1)
			})
			d = vector.add(d, dir)
		end
		
		local airs = minetest.find_nodes_in_area(
			vector.subtract(d, {x=-2, y=-2, z=-2}),
			vector.subtract(d, {x=2, y=2, z=2}),
			"air"
		)
		
		for _,p in ipairs(airs) do
			if vector.distance(p, d) - math.random() < 1.6 and not not_air(p) then
				minetest.set_node(p, {name=nodes.leaves})
			end
		end
	end
	
	
	local r = math.random(3,5)
	for i = 1,r do
		
		local rr = math.random(1,3)
		for j = 1,rr do
			pos.y = pos.y + 1
			
			if not_air(pos) then
				return
			end
			
			minetest.set_node(pos, {name = nodes.tree})
		end
		
		branch(pos)
	end
	
	
end

minetest.register_node("farming_super:durian_sapling", {
	description = "Durian Sapling",
	drawtype = "plantlike",
	waving = 1,
	visual_scale = 1.69,
	tiles = {"farming_super_durian_sapling.png"},
	inventory_image = "farming_super_durian_sapling.png",
	paramtype = "light",
-- 	paramtype2 = "meshoptions",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	groups = {snappy = 2, oddly_breakable_by_hand = 2, flammable = 1, attached_node=1, durian_sapling=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-6 / 16, -0.5, -6 / 16, 6 / 16, 1.3, 6 / 16},
	},
-- 	place_param2 = 1,
	
	on_place = function(itemstack, placer, pointed_thing)
		local n = minetest.get_node(pointed_thing.above)
		if n.name ~= "farming_super:durian_sapling" and (n.name == "air" or minetest.registered_nodes[n.name].buildable_to) then
			minetest.set_node(pointed_thing.above, {name="farming_super:durian_sapling"})
			
			local timer = minetest.get_node_timer(pointed_thing.above)
			timer:start(durian_speed.sapling + gr())
-- 			timer:start(10)
			
			itemstack:take_item(1)
		end
		
		return itemstack
	end,
	
	on_timer = function(pos, elapsed)
		local node = minetest.get_node(pos)
		
		pos.y = pos.y - 1
		local soil = minetest.get_node(pos)
		
		if minetest.get_item_group(soil.name, "soil") <= 0 then
			return
		end
		pos.y = pos.y + 1
		
		durian_tree(pos, {
			tree = "farming_super:durian_tree",
			leaves = "farming_super:durian_leaves",
		})
	end,
})

--[[
minetest.register_node("farming_super:durian_tree_seed", {
	description = "Durian Tree Seed",
	tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
	paramtype2 = "facedir",
	is_ground_content = false,
	drop = "default:tree",
	groups = {tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2},
	sounds = default.node_sound_wood_defaults(),
	on_place = function(itemstack, placer, pointed_thing)
		local p = pointed_thing.above
		durian_tree(p, {
			tree = "farming_super:durian_tree",
			leaves = "farming_super:durian_leaves",
		})
	end,
})
]]


minetest.register_abm({
	label = "durian grows fruit",
	neighbors = {"farming_super:durian_tree"},
	nodenames = {"air"},
	interval = 3,--0,
	chance = 3,--00,
	action = function(pos, node)
		local tree = minetest.find_node_near(pos, 1, "farming_super:durian_tree")
		if not tree then
			return
		end
		
		-- none above
		if tree.y < pos.y then
			return
		end
		-- no diagonals 
		if tree.y == pos.y and tree.x ~= pos.x and tree.z ~= pos.z then
			return
		end
		
		local fruits = minetest.find_nodes_in_area(
			vector.subtract(pos, {x=-2, y=-2, z=-2}),
			vector.subtract(pos, {x=2, y=2, z=2}),
			"group:durian_fruit"
		)
		
		if #fruits > 2 then return end
		
		if tree.y > pos.y then
			if tree.x ~= pos.x or tree.z ~= pos.z then
				return
			end
			minetest.set_node(pos, {name="farming_super:durian_top"})
			return
		end
		
		minetest.set_node(pos, {
			name="farming_super:durian_side", 
			param2 = minetest.dir_to_facedir(vector.subtract(pos, tree))
		})
	end,
})



minetest.register_node("farming_super:durian_seed", {
	description = "Durian Seeds",
	tiles = {"farming_super_durian_seed.png"},
	inventory_image = "farming_super_durian_seed.png",
	drawtype = "signlike",
	groups = {seed = 1, snappy = 3, attached_node = 1, flammable = 2},
	paramtype = "light",
	paramtype2 = "wallmounted",
	walkable = false,
	sunlight_propagates = true,
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
	},
	sounds = default.node_sound_dirt_defaults({
		dig = {name = "", gain = 0},
		dug = {name = "default_grass_footstep", gain = 0.2},
		place = {name = "default_place_node", gain = 0.25},
	}),
})


minetest.register_craft({
	type = "shapeless",
	output = "farming_super:durian_seed 3",
	recipe = {"farming_super:durian", "group:sword"},
	replacements = {
		{"default:sword_wood", "default:sword_wood"},
		{"default:sword_steel", "default:sword_steel"},
		{"default:sword_bronze", "default:sword_bronze"},
		{"default:sword_mese", "default:sword_mese"},
		{"default:sword_diamond", "default:sword_diamond"},
	},
})



minetest.register_abm({
	nodenames = {"farming_super:durian_seed"},
	interval  = 41,
	chance = 50,
	action = function(pos, node)
		pos.y = pos.y - 1
		local n = minetest.get_node(pos)
		if n.name == "farming:soil_wet" then
			pos.y = pos.y + 1
			minetest.set_node(pos, {name="farming_super:durian_sapling"})
		end
	end,
})



minetest.register_node("farming_super:durian_tree_mapgen", {
	description = "Durian Tree Mapgen Node",
-- 	drawtype= "airlike",
	paramtype = "light",
	groups = { },
	drop = "",
})


minetest.register_lbm({
	name = "farming_super:durian_tree_mapgen",
	nodenames = {"farming_super:durian_tree_mapgen"},
	catch_up = true,
	action = function(pos, node)
		durian_tree(pos, {
			tree = "farming_super:durian_tree",
			leaves = "farming_super:durian_leaves",
		})
	end,
})

minetest.register_abm({
	nodenames = {"farming_super:durian_tree_mapgen"},
	interval  = 5,
	chance = 1,
	catch_up = true,
	action = function(pos, node)
		durian_tree(pos, {
			tree = "farming_super:durian_tree",
			leaves = "farming_super:durian_leaves",
		})
	end,
})

minetest.register_decoration({
	name = "farming_super:durian_tree_mapgen",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass", "default:dirt_with_rainforest_litter"},
	sidelen = 16,
	noise_params = {
		offset = -0.002,
		scale = 0.03,
		spread = {x = 200, y = 200, z = 200},
		seed = 765345,
		octaves = 3,
		persist = 0.8
	},
	biomes = {"rainforest", "rainforest_ocean", "rainforest_swamp"},
	y_max = 40,
	y_min = 1,
	decoration = "farming_super:durian_tree_mapgen",
})
