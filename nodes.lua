



minetest.register_node("farming_super:pole", {
	description = "Farming Pole",
	tiles = {"default_fence_junglewood.png"},
	paramtype = "light",
	drawtype = "nodebox",
	
	node_box = {
		type = "connected",
		fixed = {-1/16, -0.5, -1/16, 1/16, 0.5, 1/16},
		connect_back = {{-1/32,  -1/2, 0,   1/32,  -15/32, 1/2 }},
		connect_left =  {{-1/2,   -1/2, -1/32, 0,   -15/32,  1/32}},
		connect_front =  {{-1/32,  -1/2,  -1/2,   1/32,  -15/32,  0 }},
		connect_right = {{ 0,   -1/2, -1/32,  1/2,   -15/32,  1/32}},
	},--[[
	node_box = {
		type = "fixed",
		fixed = {-1/16, -0.5, -1/16, 1/16, 0.5, 1/16},
	},]]
	collision_box = {
		type = "fixed",
		fixed = {-1/16, -0.5, -1/16, 1/16, 0.5, 1/16},
	},
	connects_to = {"farming_super:wire"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, plant = 1},
	sounds = default.node_sound_wood_defaults(),
})

minetest.register_craft({
	output = "farming_super:pole 1",
	recipe = {
		{"group:stick"},
		{"group:stick"},
		{"group:stick"},
	}
})



minetest.register_node("farming_super:wire", {
	description = "Farming Wire",
	tiles = {"default_fence_junglewood.png"},
	paramtype = "light",
	drawtype = "nodebox",
	node_box = {
		type = "connected",
		fixed = {-1/32, -1/2, -1/32, 1/32, -15/32, 1/32},
		connect_back = {{-1/32,  -1/2, 0,   1/32,  -15/32, 1/2 }},
		connect_left =  {{-1/2,   -1/2, -1/32, 0,   -15/32,  1/32}},
		connect_front =  {{-1/32,  -1/2,  -1/2,   1/32,  -15/32,  0 }},
		connect_right = {{ 0,   -1/2, -1/32,  1/2,   -15/32,  1/32}},
	},
	collision_box = {
		type = "connected",
-- 		fixed = {-1/2, -1/2, -1/2, 1/2, -15/32, 1/2},
		fixed = {-1/32, -1/2, -1/32, 1/32, -15/32, 1/32},
		connect_back = {{-1/32,  -1/2, 0,   1/32,  -15/32, 1/2 }},
		connect_left =  {{-1/2,   -1/2, -1/32, 0,   -15/32,  1/32}},
		connect_front =  {{-1/32,  -1/2,  -1/2,   1/32,  -15/32,  0 }},
		connect_right = {{ 0,   -1/2, -1/32,  1/2,   -15/32,  1/32}},
	},
	selection_box = {
		type = "fixed",
		fixed = {-1/2, -1/2, -1/2, 1/2, -1/4, 1/2},
	},
	connects_to = {"farming_super:wire", "farming_super:pole"},
	sunlight_propagates = true,
	is_ground_content = false,
	groups = {choppy = 2, oddly_breakable_by_hand = 2, flammable = 2, },
	sounds = default.node_sound_wood_defaults(),
})



minetest.register_craft({
	output = "farming_super:wire 16",
	recipe = {
		{"","",""},
		{"","",""},
		{"default:tin_ingot","default:tin_ingot","default:tin_ingot"},
	}
})





