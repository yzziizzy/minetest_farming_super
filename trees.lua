


local orange_speed = {
	retry = 30,
	
}


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


local function advance_trunk(pos)
	
	local meta = minetest.get_meta(pos)
	
	local stage = meta:get_int("stage")
	if stage == 0 then stage = 1 end
	
	local raw_trunks = meta:get_string("trunks")
	local trunks = minetest.deserialize(raw_trunks)
	local raw_leaves = meta:get_string("leaves")
	local leaves = minetest.deserialize(raw_leaves)

	minetest.set_node({x=pos.x, y=pos.y, z=pos.z}, {name="farming_super:tree_trunk_root_"..stage})
	
	for i = 1,stage do
		minetest.set_node({x=pos.x, y=pos.y+i, z=pos.z}, {name="farming_super:tree_trunk_"..stage})
	end
	
	meta:set_int("stage", stage + 1)
	
	if stage < 5 then
		minetest.get_node_timer(pos):start(2)
	end
end


for sz = 1,5 do
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
			fs_tree_trunk = 1,
		},
		sounds = default.node_sound_wood_defaults(),
		
		on_place = function(itemstack, placer, pointed_thing)
			local stack = minetest.rotate_node(itemstack, placer, pointed_thing)
			
			minetest.get_node_timer(pointed_thing.above):start(5)
			return stack
		end,
		
		on_timer = function(pos, elapsed)
			advance_trunk(pos)
			
			
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

--[[

minetest.register_node("farming_super:orange_sapling_"..color, {
	description = "Orange Sapling",
	drawtype = "plantlike",
	waving = 1,
-- 	visual_scale = 1.69,
	tiles = {"farming_super_orange_sapling.png"},
	inventory_image = "farming_super_orange_sapling.png",
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
	place_param2 = 1,
	
	on_place = function(itemstack, placer, pointed_thing)
		
		minetest.set_node(pointed_thing.above, {name="farming_super:orange_sapling_"..color, param2 = 1})
		local timer = minetest.get_node_timer(pointed_thing.above)
		timer:start(orange_speed.sapling + gr())
		
		itemstack:take_item(1)
		return itemstack
	end,
	
	on_timer = function(pos, elapsed)
		local node = minetest.get_node(pos)
		local def = minetest.registered_nodes[node.name]
		local c = def.orange_color
		
		pos.y = pos.y - 1
		local soil = minetest.get_node(pos)
		if soil.name ~= "farming:desert_sand_soil_wet" then
			pos.y = pos.y + 1
-- 				print("wrong soil")
			minetest.get_node_timer(pos):start(orange_speed.retry)
			return
		end
		
		pos.y = pos.y + 3
		local wire = minetest.get_node(pos)
		if wire.name ~= "farming_super:wire" then
			pos.y = pos.y - 2
			minetest.get_node_timer(pos):start(orange_speed.retry)
-- 				print("no wire")
			return
		end
		
		pos.y = pos.y - 1
		minetest.set_node(pos, {name = "farming_super:orange_leaves_"..color, param2 = 3})
		minetest.get_node_timer(pos):start(orange_speed.fruit + gr())
		pos.y = pos.y - 1
		minetest.set_node(pos, {name = "farming_super:orange_stem_"..color, param2 = 1})
	end,
})
]]
