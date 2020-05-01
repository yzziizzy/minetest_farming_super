


local orange_speed = {
	retry = 30,
	sapling = 10,
	rand = 2,
}

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
		time = 10,
	},
	[2] = {
		ymin = 1, ymax=3, ysquash = 2, yoff = 2,
		xrange = 2, zrange = 2,
		rand = .6,
		dist = 1.2,
		time = 15,
	},
	[3] = {
		ymin = 1, ymax=5, ysquash = 2, yoff = 2,
		xrange = 3, zrange = 3,
		rand = 1,
		dist = 1.6,
		time = 10,
	},
	[4] = {
		ymin = 1, ymax=6, ysquash = 2, yoff = 2,
		xrange = 3, zrange = 3,
		rand = 1,
		dist = 1.9,
		time = 15,
	},
	[5] = {
		ymin = 1, ymax = 7, ysquash = 2, yoff = 2,
		xrange = 4, zrange = 4,
		rand = 1,
		dist = 2.1,
		time = 10,
	},
	[6] = {
		ymin = 1, ymax = 8, ysquash = 2, yoff = 2,
		xrange = 4, zrange = 4,
		rand = 1.1,
		dist = 2.5,
	},
}


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
				minetest.set_node(p, {name="farming_super:tree_leaves_1"})
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
			
			minetest.get_node_timer(pointed_thing.above):start(5)
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

	
local leaf_defs = {
	"default_leaves.png",
	"default_leaves.png^farming_super_flowers_overlay_w_y.png",
	"default_leaves.png^farming_super_oranges_overlay_1.png",
	"default_leaves.png^farming_super_oranges_overlay_2.png",
	"default_leaves.png^farming_super_oranges_overlay_3.png",
	"default_leaves.png^farming_super_oranges_overlay_4.png",
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
	2,
	3,
	4,
	5,
	6,
	7,
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
		
		on_timer = function(pos, elapsed)
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
		end,
		
		on_place = function(itemstack, placer, pointed_thing)
			local stack = minetest.rotate_node(itemstack, placer, pointed_thing)
			
			minetest.get_node_timer(pointed_thing.above):start(leaf_times[i])
			return stack
		end,
	}
	
	if leaf_punch[i] ~= nil then
		def.on_punch = leaf_punch[i]
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
	interval  = 1,
	chance = 3,
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
	nodenames = {"group:tree_trunk_root_fertile"},
	interval  = 30,
	chance = 1,
	action = function(pos, node)
		
		local meta = minetest.get_meta(pos)
		
		local stage = meta:get_int("stage")
		if stage == 0 then stage = 1 end
		
		local m = stage_data[stage]
		
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
			return -- don't re-flower, for debugging
		end
		
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
		
	end,
})

