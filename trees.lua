


local orange_speed = {
	retry = 30,
	sapling = 500,
	rand = 20,
	fruiting = 600,
	tree_growth = 300,
}

--[[
local orange_speed = {
	retry = 30,
	sapling = 10,
	rand = 2,
	fruiting = 1,
}
]]


local function gr()
	return math.random(orange_speed.rand)
end

-- follow tree trunks down to the root
local function find_bottom(pos)
	local p2 = {x=pos.x, y=pos.y, z=pos.z}
	
	local n = minetest.get_node(p2)
	local name = n.name
	
	for i = 1,10 do
		p2.y = p2.y - 1
		local n = minetest.get_node(p2)
		if n.name ~= name then
			p2.y = p2.y + 1
			return true, p2, n.name
		end
	end
	
	return false, p2, "air"
end


local stage_data = {
	[1] = {
		ymin = 1, ymax=2, ysquash = 2, yoff = 2,
		xrange = 1, zrange = 1,
		rand = .2,
		dist = 1.1,
		time = 10 * orange_speed.tree_growth,
	},
	[2] = {
		ymin = 1, ymax=3, ysquash = 2, yoff = 2,
		xrange = 2, zrange = 2,
		rand = .6,
		dist = 1.2,
		time = 15 * orange_speed.tree_growth,
	},
	[3] = {
		ymin = 1, ymax=5, ysquash = 2, yoff = 2,
		xrange = 3, zrange = 3,
		rand = 1,
		dist = 1.6,
		time = 10 * orange_speed.tree_growth,
	},
	[4] = {
		ymin = 1, ymax=6, ysquash = 2, yoff = 2,
		xrange = 3, zrange = 3,
		rand = 1,
		dist = 1.9,
		time = 15 * orange_speed.tree_growth,
	},
	[5] = {
		ymin = 1, ymax = 7, ysquash = 2, yoff = 2,
		xrange = 4, zrange = 4,
		rand = 1,
		dist = 2.1,
		time = 10 * orange_speed.tree_growth,
	},
	[6] = {
		ymin = 1, ymax = 8, ysquash = 2, yoff = 2,
		xrange = 4, zrange = 4,
		rand = 1.1,
		dist = 2.5
	},
}


local function install_tree(pos, stage, meta, leaf_list)

	local m = stage_data[stage]
	
	local raw_trunks = meta:get_string("trunks")
	local trunks = minetest.deserialize(raw_trunks)
	local raw_leaves = meta:get_string("leaves")
	local leaves = minetest.deserialize(raw_leaves)
	if not leaves then
		leaves = {}
	end
	
	for _,v in ipairs(leaves) do
		minetest.set_node(v, {name="air"})
	end
	
	for x = -m.xrange,m.xrange do
	for y = m.ymin,m.ymax do
	for z = -m.zrange,m.zrange do
		local y2 = (y-m.yoff) / m.ysquash
		local d = math.sqrt(x*x + z*z + y2*y2)
-- 		if d  < (stage/2) +  math.random() then
		if d  < m.dist +  math.random() * m.rand then
			local p = {x=pos.x+x, y=pos.y+y, z=pos.z+z}
			local n = minetest.get_node(p)
			if n.name == "air" then
-- 				minetest.set_node(p, {name="farming_super:tree_leaves_1"})
				minetest.set_node(p, {name=leaf_list[math.random(#leaf_list)]})
				table.insert(leaves, p)
			end
		end
	end
	end
	end
	
	
	minetest.swap_node({x=pos.x, y=pos.y, z=pos.z}, {name="farming_super:tree_trunk_root_"..stage})
	
	for i = 1,stage do
		minetest.set_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="farming_super:tree_trunk_"..stage})
	end
	
	meta:set_string("leaves", minetest.serialize(leaves))
	meta:set_int("stage", stage + 1)

end



local function advance_trunk(pos, elapsed)
	
	local meta = minetest.get_meta(pos)
	
	local stage = meta:get_int("stage")
	if stage == 0 then stage = 1 end
	
	local m = stage_data[stage]
	if stage >= 6 then
		stage = 6
	else
		-- calculate how many steps should have elapsed
		while elapsed > m.time + orange_speed.rand do
			elapsed = m.time + orange_speed.rand
			
			stage = stage + 1
			
			if stage >= 6 then
				stage = 6
				break
			end
			
			m = stage_data[stage]
		end
	end
	
	m = stage_data[stage]
	
	install_tree(pos, stage, meta, {"farming_super:tree_leaves_1"})
	
	if stage < 6 then
		minetest.get_node_timer(pos):start(m.time)
	end
end


local function install_mapgen_tree(pos)
	local stage = math.random(1,6)
	local meta = minetest.get_meta(pos)
	
	install_tree(pos, stage, meta, {"farming_super:tree_leaves_1", "farming_super:tree_leaves_1", "farming_super:tree_leaves_6"})
	
	local m = stage_data[stage]
	if stage < 6 then
		minetest.get_node_timer(pos):start(m.time)
	end
	
end


for sz = 1,6 do
	local q = sz * 1
	minetest.register_node("farming_super:tree_trunk_root_"..sz, {
		description = "Tree Root",
		tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		drawtype = "nodebox",
		
		node_box = {
			type = "fixed",
			fixed = {-q/16, -0.5, -q/16, q/16, 0.5, q/16},
		},
		sunlight_propagates = true,
		is_ground_content = false,
		groups = {
			tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, plant = 1,
			fs_tree_trunk = 1, tree_trunk_root_fertile = 1,
		},
		sounds = default.node_sound_wood_defaults(),
		
		on_place = function(itemstack, placer, pointed_thing)
			local stack = minetest.rotate_node(itemstack, placer, pointed_thing)
			
			local m = stage_data[sz]
			if m.time then
				minetest.get_node_timer(pointed_thing.above):start(m.time)
			end
			return stack
		end,
		
		on_timer = function(pos, elapsed)
			advance_trunk(pos, elapsed)
		end,
	})
	
	minetest.register_node("farming_super:tree_trunk_"..sz, {
		description = "Tree",
		tiles = {"default_tree_top.png", "default_tree_top.png", "default_tree.png"},
		paramtype = "light",
		paramtype2 = "facedir",
		drawtype = "nodebox",
		
		node_box = {
			type = "fixed",
			fixed = {-q/16, -0.5, -q/16, q/16, 0.5, q/16},
		},
		sunlight_propagates = true,
		is_ground_content = false,
		groups = {
			tree = 1, choppy = 2, oddly_breakable_by_hand = 1, flammable = 2, plant = 1,
			fs_tree_trunk = 1, 
		},
		sounds = default.node_sound_wood_defaults(),
		on_place = minetest.rotate_node,
		
	})
	
	
	
end


minetest.register_craftitem("farming_super:orange", {
	description = "Oranges",
	inventory_image = "farming_super_oranges_overlay_4.png",
	on_use = minetest.item_eat(2),
	groups = {flammable = 1},
})


minetest.register_node("farming_super:orange_rotten", {
	description = "Rotten Oranges",
	tiles = {"farming_super_oranges_overlay_rotten.png"},
	inventory_image = "farming_super_oranges_overlay_rotten.png",
	drawtype = "nodebox",
	groups = {snappy = 3, oddly_breakable_by_hand=3, falling_node = 1,},
	paramtype = "light",
	walkable = false,
	sunlight_propagates = true,
	buildable_to = true,
	node_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.475, 0.5},
	},
	selection_box = {
		type = "fixed",
		fixed = {-0.5, -0.5, -0.5, 0.5, -0.375, 0.5},
	},
	on_use = minetest.item_eat(-1),
-- 	on_place = minetest.rotate_node,
})

minetest.register_node("farming_super:orange_seed", {
	description = "Orange Seeds",
	tiles = {"farming_super_oranges_seed.png"},
	inventory_image = "farming_super_oranges_seed.png",
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
	output = "farming_super:orange_seed 3",
	recipe = {"farming_super:orange", "group:sword"},
	replacements = {
		{"default:sword_wood", "default:sword_wood"},
		{"default:sword_steel", "default:sword_steel"},
		{"default:sword_bronze", "default:sword_bronze"},
		{"default:sword_mese", "default:sword_mese"},
		{"default:sword_diamond", "default:sword_diamond"},
	},
})
minetest.register_craft({
	type = "shapeless",
	output = "farming_super:orange_seed 2",
	recipe = {"farming_super:orange_rotten", "group:sword"},
	replacements = {
		{"default:sword_wood", "default:sword_wood"},
		{"default:sword_steel", "default:sword_steel"},
		{"default:sword_bronze", "default:sword_bronze"},
		{"default:sword_mese", "default:sword_mese"},
		{"default:sword_diamond", "default:sword_diamond"},
	},
})

	
local leaf_defs = {
	"default_leaves.png",
	"default_leaves.png^farming_super_flowers_overlay_w_y.png",
	"default_leaves.png^farming_super_oranges_overlay_1.png",
	"default_leaves.png^farming_super_oranges_overlay_2.png",
	"default_leaves.png^farming_super_oranges_overlay_3.png",
	"default_leaves.png^farming_super_oranges_overlay_4.png",
	"default_leaves.png^farming_super_oranges_overlay_rotten.png",
}
local leaf_drops = {
	"farming_super:tree_leaves_1",
	"farming_super:tree_leaves_1",
	"farming_super:tree_leaves_1",
	"farming_super:tree_leaves_1",
	"farming_super:tree_leaves_1",
	{
		max_items = 1,
		items = {
			{items={--[["farming_super:tree_leaves_1",]] "farming_super:orange 2"}, rarity = 2},
			{items={--[["farming_super:tree_leaves_1",]] "farming_super:orange 3"}, rarity = 4},
		},
	},
	{
		max_items = 1,
		items = {
			{items={--[["farming_super:tree_leaves_1",]] "farming_super:orange_rotten 2"}, rarity = 2},
			{items={--[["farming_super:tree_leaves_1",]] "farming_super:orange_rotten 3"}, rarity = 4},
		},
	},
}

local leaf_punch = {
	[6] = function(pos, node, puncher)
		local inv = puncher:get_inventory()
		
		local drops = minetest.get_node_drops(node.name)
		for _,d in pairs(drops) do
			inv:add_item("main", d)
		end
		
		minetest.set_node(pos, {name = "farming_super:tree_leaves_1",})
-- 		minetest.get_node_timer(pos):start(grape_speed.fruit + gr())
	end,
}

local leaf_times = { -- time to get to the next stage
	2 * orange_speed.fruiting,
	3 * orange_speed.fruiting,
	4 * orange_speed.fruiting,
	5 * orange_speed.fruiting,
	6 * orange_speed.fruiting,
	7 * orange_speed.fruiting,
-- 	10,
}

-- fruiting leaves
for i,d in pairs(leaf_defs) do
	local def = {
		description = "Tree Leaves",
		drawtype = "allfaces_optional",
		waving = 1,
		tiles = {d},
		special_tiles = {d},
		paramtype = "light",
		drop = leaf_drops[i],
		is_ground_content = false,
		groups = {snappy = 3, fs_leafdecay = 3, flammable = 2, leaves = 1},
		sounds = default.node_sound_leaves_defaults(),
		leaf_stage = i,
	}
	
	if leaf_punch[i] ~= nil then
		def.on_punch = leaf_punch[i]
	end
	
	if leaf_times[i] ~= nil then
		def.on_timer = function(pos, elapsed)
			local node = minetest.get_node(pos)
			local def = minetest.registered_nodes[node.name]
			local stage = def.leaf_stage
			if not stage or not leaf_times[stage+1] then
				return
			end
			
			-- less fruit in the tree's interior
			if stage == 1 then
				local airs = minetest.find_nodes_in_area(
					{x=pos.x-1, y=pos.y-1, z=pos.z-1}, 
					{x=pos.x+1, y=pos.y+1, z=pos.z+1}, 
					{"air"}
				)
				
				if #airs < 7 and math.random() < .75 then
					return
				end
			end
			
			
			stage = stage + 1
			minetest.set_node(pos, {name="farming_super:tree_leaves_"..stage})
			minetest.get_node_timer(pos):start(leaf_times[stage])
		end
		
		def.on_place = function(itemstack, placer, pointed_thing)
			local stack = minetest.rotate_node(itemstack, placer, pointed_thing)
			
			minetest.get_node_timer(pointed_thing.above):start(leaf_times[i])
			return stack
		end
	end
	
	minetest.register_node("farming_super:tree_leaves_"..i, def)
end



minetest.register_node("farming_super:orange_sapling", {
	description = "Orange Sapling",
	drawtype = "plantlike",
	waving = 1,
-- 	visual_scale = 1.69,
	tiles = {"farming_super_oranges_sapling.png"},
	inventory_image = "farming_super_oranges_sapling.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	sunlight_propagates = true,
	walkable = false,
	buildable_to = false,
	groups = {snappy = 2, oddly_breakable_by_hand = 2, flammable = 1, orange_sapling=1},
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-5 / 16, -0.5, -5 / 16, 5 / 16, 0.5, 5 / 16},
	},
	place_param2 = 0,
	
	on_place = function(itemstack, placer, pointed_thing)
		
		minetest.set_node(pointed_thing.above, {name="farming_super:orange_sapling", param2 = 0})
		local timer = minetest.get_node_timer(pointed_thing.above)
		timer:start(orange_speed.sapling + gr())
		
		itemstack:take_item(1)
		return itemstack
	end,
	
	on_timer = function(pos, elapsed)
		advance_trunk(pos, 0)
	end,
})





minetest.register_abm({
	nodenames = {"farming_super:orange_seed"},
	interval  = 41,
	chance = 50,
	action = function(pos, node)
		pos.y = pos.y - 1
		local n = minetest.get_node(pos)
		if n.name == "farming:soil_wet" then
			pos.y = pos.y + 1
			minetest.set_node(pos, {name="farming_super:orange_sapling"})
		end
	end,
})


minetest.register_abm({
	nodenames = {"farming_super:tree_leaves_6"}, -- with oranges
	interval = 60,
	chance = 120,
	action = function(pos, node)
		minetest.set_node(pos, {name="farming_super:tree_leaves_7"})
	end,
})

minetest.register_abm({
	nodenames = {"farming_super:tree_leaves_7"}, -- with rotten oranges
	interval = 60,
	chance = 120,
	action = function(pos, node)
		minetest.set_node(pos, {name="farming_super:tree_leaves_1"})
		-- BUG still in root's flowers list
		
		for i = 1,12 do
			pos.y = pos.y - 1
			local n = minetest.get_node(pos)
			if n.name ~= "air" and  minetest.get_item_group("leaves",n.name) == 0 then
				pos.y = pos.y + 1
				local n2 = minetest.get_node(pos)
				if n2.name == "air" or minetest.registered_nodes[n2.name].buildable_to then
					minetest.set_node(pos, {name="farming_super:orange_rotten"})
					break
				end
			end
		end
	end,
})

minetest.register_abm({
	nodenames = {"group:tree_trunk_root_fertile"},
	interval  = 60 * 10,
	chance = 1,
	action = function(pos, node)
		
		local gtime = minetest.get_gametime()
		local time = gtime % (60 * 60)
		
		local meta = minetest.get_meta(pos)
		
		local mode = meta:get_int("mode")
		
		if mode == 0 then -- mode 0 means no flowers or fruit
			
			local raw_leaves = meta:get_string("leaves")
			local leaves = minetest.deserialize(raw_leaves)
			if not leaves then
				return
			end
			
			local raw_flowers = meta:get_string("flowers")
			local flowers = minetest.deserialize(raw_flowers)
			if not flowers then
				flowers = {}
			else
-- 				return -- don't re-flower, for debugging
			end
			
			
			local stage = meta:get_int("stage")
			if stage == 0 then stage = 1 end
			
			local m = stage_data[stage]
			
			for _,v in ipairs(leaves) do
				if math.random() < 0.1 * stage then
					local timer = minetest.get_node_timer(v)
					if not timer:is_started() then
						timer:start(leaf_times[1])
						table.insert(flowers, v)
					end
				end
			end
			
			meta:set_string("flowers", minetest.serialize(flowers))
			meta:set_int("mode", 1)
		
		elseif mode == 1 then -- flowering and fruiting
			
			
			meta:set_string("flowers", minetest.serialize({}))
			meta:set_int("mode", 0)
		
		elseif mode == 2 then -- post-fruiting
		
		end
			
	end,
})



minetest.register_node("farming_super:orange_tree_mapgen", {
	description = "Orange Tree Mapgen Node",
-- 	drawtype= "airlike",
	paramtype = "light",
	groups = { },
	drop = "",
})


minetest.register_lbm({
	name = "farming_super:orange_tree_mapgen",
	nodenames = {"farming_super:orange_tree_mapgen"},
	catch_up = true,
	action = function(pos, node)
		install_mapgen_tree(pos)
	end,
})

minetest.register_abm({
	nodenames = {"farming_super:orange_tree_mapgen"},
	interval  = 5,
	chance = 1,
	catch_up = true,
	action = function(pos, node)
		install_mapgen_tree(pos)
	end,
})

minetest.register_decoration({
	name = "farming_super:orange_tree_mapgen",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass"},
	sidelen = 16,
	noise_params = {
		offset = -0.008,
		scale = 0.01,
		spread = {x = 200, y = 200, z = 200},
		seed = 567446,
		octaves = 3,
		persist = 0.7
	},
	biomes = {"grassland", "deciduous_forest"},
	y_max = 80,
	y_min = 1,
	decoration = "farming_super:orange_tree_mapgen",
})
