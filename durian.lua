


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
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 2, plant = 1},
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
	connects_to = {"group:tree"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {choppy = 3, oddly_breakable_by_hand = 2, flammable = 2, plant = 1},
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
	on_place = minetest.rotate_node
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
-- 	drop = {
-- 		max_items = 1,
-- 		items = {
-- 			{items = {"default:acacia_sapling"}, rarity = 20},
-- 			{items = {"default:acacia_leaves"}}
-- 		}
-- 	},
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


local function durian_tree(pos)
	local oy = pos.y
	
	minetest.set_node(pos, {name="farming_super:durian_tree"})
	
	for j = 1,4 do
		pos.y = pos.y + 1
		
		if not_air(pos) then
			print("not air")
			return
		end
		
		minetest.set_node(pos, {name="farming_super:durian_tree"})
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
				name="farming_super:durian_tree",
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
				minetest.set_node(p, {name="farming_super:durian_leaves"})
			end
		end
	end
	
	
	local r = math.random(3,5)
	for i = 1,r do
		
		local rr = math.random(1,3)
		for j = 1,rr do
			pos.y = pos.y + 1
			
			if not_air(pos) then
				print("not air")
				return
			end
			
			minetest.set_node(pos, {name="farming_super:durian_tree"})
		end
		
		branch(pos)
	end
	
	
end



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
		durian_tree(p)
	end,
})



minetest.register_abm({
	label = "durian grows",
	neighbors = {"farming_super:durian_tree"},
	nodenames = {"air"},
	interval = 1,
	chance = 30,
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
