farming_super = {}


local modpath = minetest.get_modpath("farming_super")

dofile(modpath.."/nodes.lua")
dofile(modpath.."/api.lua")
dofile(modpath.."/vines.lua")
dofile(modpath.."/hops.lua")
dofile(modpath.."/grapes.lua")
dofile(modpath.."/trees.lua")



--[[
TODO: crops

artichoke
asparagus
barley
beans
black pepper
broccoli
brussels sprouts
canola
cassava
celery
eggplant
garlic
ginger
green onions on harvesting young onions
hemp
jicama
leeks
lentils
lettuce
mustard
oats
okra
peanuts
peppers
potatoes
rhubarb
rice
sorghum
squash
strawberry
sugar beets
sugarcane
sunflower
sweet potatoes
taro
tomato
turnips
yams



much later:
	cucumber -- gourds
	grapes
	hops
	kiwi
	lotus


TODO: features
corn oil processing
sugar processing


TODO: core
pests, locusts like butterflies
stick or strings for plants to grow on
wilting on low water
dead version of all plants
yellowing on bad soil

fruit trees
	apple, proper
	all citrus
	pears
	durian, jackfruit
fruit flies
rotten fruit on the ground
tree hybrids
smudge pots
vinegar

scythe for harvesting larger squares
better solution for excessive hoe clicking

drop-in replacement for farming_plus

BUGS:
seed will move to first stage without wet soil
fix on_place to not re-place the same plant and waste inventory

]]


minetest.register_craftitem("farming_super:corn", {
	description = "Corn",
	inventory_image = "farming_super_corn.png",
	on_use = minetest.item_eat(1),
})
minetest.register_craftitem("farming_super:cooked_corn", {
	description = "Cooked Corn",
	inventory_image = "farming_super_cooked_corn.png",
	on_use = minetest.item_eat(4),
})

minetest.register_craft({
	type = "cooking",
	cooktime = 10,
	output = "farming_super:cooked_corn",
	recipe = "farming_super:corn"
})




local corndrop = {
	max_items = 6,
	items = {
		{ items = {'farming_super:seed_corn'} },
		{ items = {'farming_super:seed_corn'}, rarity = 2},
		{ items = {'farming_super:seed_corn'}, rarity = 5},
		{ items = {'farming_super:corn 2'} },
		{ items = {'farming_super:corn'}, rarity = 2 },
		{ items = {'farming_super:corn'}, rarity = 5 }
	}
}

-- todo: extra step where corn dries out and gives no fruit but more seeds


-- regular corn with standard yield
farming_super.register_plant("farming_super:corn", {
	description = "Corn",
	paramtype2 = "meshoptions",
	inventory_image = "farming_super_seed_corn.png",
	seed_variants = {
		{minNitrogen=15, maxNitrogen=16, name="farming_super:corn_lg"},
		{minNitrogen=10, maxNitrogen=14, name="farming_super:corn"},
		{minNitrogen=3,  maxNitrogen=9,  name="farming_super:corn_sm"},
		{minNitrogen=0,  maxNitrogen=2,  name="death"},
	},
	steps = {3, 2, 2}, -- phases, steps per tier 
	default_drop = {},
	drops = {
		p3s2t2 = corndrop, -- phase 3, step 2, tier 2
	},
	textures = { -- overrides default texture naming, allowing reuse
		p2s1t2 = "farming_super_corn_1_1_1.png", 
		p2s2t1 = "farming_super_corn_2_1_1.png", 
		p2s2t2 = "farming_super_corn_1_3_1.png", 
		
		p3s1t1 = "farming_super_corn_2_1_1.png", 
		p3s1t2 = "farming_super_corn_2_1_1.png", 
		p3s1t3 = "farming_super_corn_1_2_1.png", 
		
		p3s2t1 = "farming_super_corn_2_1_1.png", 
		p3s2t2 = "farming_super_corn_4_2_2.png", 
		p3s2t3 = "farming_super_corn_4_2_4.png", 
	},
	minlight = 13,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4, use_nitrogen = 2},
	place_param2 = 2,
})


-- smaller corn with less yield
farming_super.register_plant("farming_super:corn_sm", {
	description = "Corn",
	paramtype2 = "meshoptions",
	inventory_image = "farming_super_seed_corn.png",
	steps = {3, 4}, -- phases, steps per tier 
	default_drop = {},
	no_seed = true,  -- seeds and harvests are already registered
	no_harvest = true, 
	drops = {
		p2s4t1 = {
			max_items = 4,
			items = {
				{ items = {'farming_super:seed_corn'} },
				{ items = {'farming_super:seed_corn'}, rarity = 5},
				{ items = {'farming_super:corn '} },
				{ items = {'farming_super:corn'}, rarity = 5 }
			}
		}, -- phase 3, step 2, tier 2
	},
	textures = { -- overrides default texture naming, allowing reuse
		base = "farming_super_corn",
		p2s1t2 = "farming_super_corn_1_1_1.png", 
		
		p2s2t1 = "farming_super_corn_2_1_1.png", 
		p2s2t2 = "farming_super_corn_1_2_1.png", 
		
		p2s3t1 = "farming_super_corn_2_1_1.png", 
		p2s3t2 = "farming_super_corn_1_3_1.png", 

		p2s4t1 = "farming_super_corn_4_2_2.png", 
		p2s4t2 = "farming_super_corn_4_2_4.png",
	},
	minlight = 13,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4, use_nitrogen = 1},
	place_param2 = 2,
})


-- large corn with large yield
farming_super.register_plant("farming_super:corn_lg", {
	description = "Corn",
	paramtype2 = "meshoptions",
	inventory_image = "farming_super_seed_corn.png",
	steps = {3, 1, 1, 2}, -- phases, steps per tier 
	default_drop = {},
	no_seed = true,  -- seeds and harvests are already registered
	no_harvest = true, 
	drops = {
		p4s2t2 = corndrop, -- phase 4, step 2, tier 2
		p4s2t3 = corndrop,
	},
	textures = { -- overrides default texture naming, allowing reuse
		base = "farming_super_corn",
		p2s1t2 = "farming_super_corn_1_2_1.png", 
		
		p3s1t1 = "farming_super_corn_2_1_1.png", 
		p3s1t2 = "farming_super_corn_2_1_1.png", 
		p3s1t3 = "farming_super_corn_1_2_1.png", 
		
		p4s1t1 = "farming_super_corn_2_1_1.png", 
		p4s1t2 = "farming_super_corn_2_1_1.png", 
		p4s1t3 = "farming_super_corn_2_1_1.png", 
		p4s1t4 = "farming_super_corn_1_2_1.png", 
		
		p4s2t1 = "farming_super_corn_2_1_1.png", 
		p4s2t3 = "farming_super_corn_4_2_2.png", 
	},
	minlight = 13,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4, use_nitrogen = 3},
	place_param2 = 2,
})


--[[
minetest.register_decoration({
	name = "farming_super:corn_sm",
	deco_type = "simple",
	place_on = {"default:dry_dirt_with_dry_grass", "default:dry_dirt"},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 9752,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"savanna",},
	y_max = 128,
	y_min = 5,
	decoration = "farming_super:corn_sm",
	param2 = 3,
})
]]

-- standard soybeans
farming_super.register_plant("farming_super:soybeans", {
	description = "Soybeans",
	paramtype2 = "meshoptions",
	place_param2 = "X",
	inventory_image = "farming_super_seed_soybeans.png",
	steps = {5}, -- phases, steps per tier 
	default_drop = {},
	drops = {
		p1s5t1 = {
			max_items = 5,
			items = {
				{ items = {'farming_super:seed_soybeans'} },
				{ items = {'farming_super:seed_soybeans'}, rarity = 2},
				{ items = {'farming_super:seed_soybeans'}, rarity = 5},
				{ items = {'farming_super:soybeans 2'} },
				{ items = {'farming_super:soybeans'}, rarity = 3 }
			}
		}, 
	},
	minlight = 13,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4, fix_nitrogen = 1},
})




farming_super.register_plant("farming_super:onion_yellow", {
	description = "Yellow Onion",
	paramtype2 = "meshoptions",
	place_param2 = "hatch",
	inventory_image = "farming_super_seed_yellow_onion.png",
	steps = {4}, -- phases, steps per tier 
	step_len = {1, 2, 3, 4},
	default_drop = {},
	drops = {
		p1s4t1 = {
			max_items = 4,
			items = {
				{ items = {'farming_super:seed_onion_yellow'} },
				{ items = {'farming_super:seed_onion_yellow'}, rarity = 2},
				{ items = {'farming_super:seed_onion_yellow'}, rarity = 5},
				{ items = {'farming_super:onion_yellow'} },
			}
		}, 
	},
	textures = { -- overrides default texture naming, allowing reuse
		base = "farming_super_onion",
		p1s4t1 = "farming_super_onion_yellow_1_4_1.png", 
	},
	minlight = 13,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4},
})


farming_super.register_plant("farming_super:onion_white", {
	description = "White Onion",
	paramtype2 = "meshoptions",
	place_param2 = "#",
	inventory_image = "farming_super_seed_white_onion.png",
	steps = {4}, -- phases, steps per tier 
	step_len = {1, 2, 3, 4},
	default_drop = {},
	drops = {
		p1s4t1 = {
			max_items = 4,
			items = {
				{ items = {'farming_super:seed_white_onion'} },
				{ items = {'farming_super:seed_white_onion'}, rarity = 2},
				{ items = {'farming_super:seed_white_onion'}, rarity = 5},
				{ items = {'farming_super:onion_white'} },
			}
		}, 
	},
	textures = { -- overrides default texture naming, allowing reuse
		base = "farming_super_onion",
		p1s4t1 = "farming_super_onion_white_1_4_1.png", 
	},
	minlight = 13,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4},
})



farming_super.register_plant("farming_super:onion_red", {
	description = "Red Onion",
	paramtype2 = "meshoptions",
	place_param2 = "#",
	inventory_image = "farming_super_seed_red_onion.png",
	steps = {4}, -- phases, steps per tier 
	step_len = {1, 2, 3, 4},
	default_drop = {},
	drops = {
		p1s4t1 = {
			max_items = 4,
			items = {
				{ items = {'farming_super:seed_red_onion'} },
				{ items = {'farming_super:seed_red_onion'}, rarity = 2},
				{ items = {'farming_super:seed_red_onion'}, rarity = 5},
				{ items = {'farming_super:onion_red'} },
			}
		}, 
	},
	textures = { -- overrides default texture naming, allowing reuse
		base = "farming_super_onion",
		p1s4t1 = "farming_super_onion_red_1_4_1.png", 
	},
	minlight = 13,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4},
})


minetest.register_decoration({
	name = "farming_super:onion_5_1",
	deco_type = "simple",
	place_on = {"default:dry_dirt_with_dry_grass", "default:dry_dirt"},
	sidelen = 16,
	noise_params = {
		offset = -0.0002,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 2548,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"savanna",},
	y_max = 128,
	y_min = 5,
	decoration = {
		"farming_super:onion_red_4_1",
		"farming_super:onion_white_4_1",
		"farming_super:onion_yellow_4_1",
	},
	param2 = 3,
})




local function place_pineapple(itemstack, placer, pointedthing)
	local above = pointedthing.above
	local under = pointedthing.under
	local soil = minetest.get_node_or_nil(under)
	if not soil then
		return itemstack
	end
	
	if minetest.get_item_group(soil.name, "wet") < 1 then
		return itemstack
	end
	if minetest.get_item_group(soil.name, "desert") < 1 then
		return itemstack
	end
	
	minetest.set_node(above, {name="farming_super:pineapple_1_1", param2=2 })
	farming_super.tick_node(above, 1)
	
	itemstack:take_item(1)
	return itemstack
end

minetest.register_craftitem("farming_super:pineapple_sucker", {
	description = "Pineapple Sucker",
	inventory_image = "farming_super_pineapple_sucker.png",
	on_place = place_pineapple,
})
minetest.register_craftitem("farming_super:pineapple_top", {
	description = "Pineapple Top",
	inventory_image = "farming_super_pineapple_top.png",
	on_place = place_pineapple,
})
minetest.register_craftitem("farming_super:pineapple", {
	description = "Pineapple",
	inventory_image = "farming_super_pineapple.png",
	on_use = minetest.item_eat(6, "farming_super:pineapple_top"),
})


farming_super.register_plant("farming_super:pineapple", {
	description = "Pineapple",
	paramtype2 = "meshoptions",
	place_param2 = "hex",
	inventory_image = "farming_super_pineapple_top.png",
	steps = {5}, -- phases, steps per tier 
	default_drop = {},
	no_seed = true, -- pineapples don't have seeds in practice
	no_harvest = true, -- defined above for special behavior
	drops = {
		p1s5t1 = {
			max_items = 2,
			items = {
				{ items = {'farming_super:pineapple'} },
				{ items = {'farming_super:pineapple_sucker'}, rarity = 4 },
			}
		}, 
	},
	minlight = 13,
	maxlight = 15,
	fertility = {"desert"},
	groups = {flammable = 4},
})

minetest.register_decoration({
	name = "farming_super:pineapple_5_1",
	deco_type = "simple",
	place_on = {"default:desert_sand", "default:sand"},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 3456,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"desert", "sandstone_desert", "desert_ocean"},
	y_max = 6,
	y_min = 0,
	decoration = "farming_super:pineapple_5_1",
	param2 = 2,
})



-- standard soybeans
farming_super.register_plant("farming_super:soybeans", {
	description = "Soybeans",
	paramtype2 = "meshoptions",
	place_param2 = "X",
	inventory_image = "farming_super_seed_soybeans.png",
-- 	visual_scale = 1.3,
	step_len = {1, 2, 2, 2},
	steps = {5}, -- phases, steps per tier 
	default_drop = {},
	drops = {
		p1s5t1 = {
			max_items = 5,
			items = {
				{ items = {'farming_super:seed_soybeans'} },
				{ items = {'farming_super:seed_soybeans'}, rarity = 2},
				{ items = {'farming_super:seed_soybeans'}, rarity = 5},
				{ items = {'farming_super:soybeans 2'} },
				{ items = {'farming_super:soybeans'}, rarity = 3 }
			}
		}, 
	},
	minlight = 13,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4, fix_nitrogen = 1},
})


minetest.register_decoration({
	name = "farming_super:soybeans_5_1",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass",},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 9764,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"grassland",},
	y_max = 128,
	y_min = 5,
	decoration = "farming_super:soybeans_5_1",
	param2 = 0,
})



-- standard cabbage
farming_super.register_plant("farming_super:cabbage", {
	description = "Cabbage",
	paramtype2 = "meshoptions",
	place_param2 = "X",
	inventory_image = "farming_super_seed_cabbage.png",
-- 	visual_scale = 1.3,
	steps = {4}, -- phases, steps per tier 
	step_len = {1, 1, 2, 2},
	textures = { -- overrides default texture naming, allowing reuse
		p1s1t1 = "farming_super_green_pixels_1.png", 
		p1s2t1 = "farming_super_green_pixels_2.png", 
		p1s3t1 = "farming_super_cabbage_3.png", 
		p1s4t1 = "farming_super_cabbage_4.png", 
	},
	default_drop = {},
	drops = {
		p1s4t1 = {
			max_items = 4,
			items = {
				{ items = {'farming_super:seed_cabbage'} },
				{ items = {'farming_super:seed_cabbage'}, rarity = 2},
				{ items = {'farming_super:seed_cabbage'}, rarity = 5},
				{ items = {'farming_super:cabbage'} },
			}
		}, 
	},
	minlight = 10,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4, },
})


minetest.register_decoration({
	name = "farming_super:cabbage_4_1",
	deco_type = "simple",
	place_on = {"default:dirt_with_rainforest_litter",},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 5278,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"jungle",},
	y_max = 30,
	y_min = 1,
	decoration = "farming_super:cabbage_4_1",
	param2 = 0,
})



-- standard cauliflower
farming_super.register_plant("farming_super:cauliflower", {
	description = "Cauliflower",
	paramtype2 = "meshoptions",
	place_param2 = "X",
	inventory_image = "farming_super_seed_cauliflower.png",
-- 	visual_scale = 1.3,
	steps = {4}, -- phases, steps per tier 
	step_len = {1, 1, 2, 2},
	textures = { -- overrides default texture naming, allowing reuse
		p1s1t1 = "farming_super_green_pixels_1.png", 
		p1s2t1 = "farming_super_green_pixels_2.png", 
		p1s3t1 = "farming_super_cabbage_3.png", 
		p1s4t1 = "farming_super_cauliflower_4.png", 
	},
	default_drop = {},
	drops = {
		p1s4t1 = {
			max_items = 4,
			items = {
				{ items = {'farming_super:seed_cauliflower'} },
				{ items = {'farming_super:seed_cauliflower'}, rarity = 2},
				{ items = {'farming_super:seed_cauliflower'}, rarity = 5},
				{ items = {'farming_super:cauliflower'} },
			}
		}, 
	},
	minlight = 10,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4, },
})


minetest.register_decoration({
	name = "farming_super:cauliflower_4_1",
	deco_type = "simple",
	place_on = {"default:dirt_with_rainforest_litter",},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 8743,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"jungle",},
	y_max = 30,
	y_min = 1,
	decoration = "farming_super:cauliflower_4_1",
	param2 = 0,
})

-- standard radish
farming_super.register_plant("farming_super:radish", {
	description = "Radish",
	paramtype2 = "meshoptions",
	place_param2 = "hatch",
	inventory_image = "farming_super_seed_radish.png",
-- 	visual_scale = 1.3,
	eat_value = 1,
	steps = {4}, -- phases, steps per tier 
	step_len = {1, 2, 2, 2},
	textures = { -- overrides default texture naming, allowing reuse
		p1s1t1 = "farming_super_2x_green_pixels_1.png", 
		p1s2t1 = "farming_super_2x_green_pixels_2.png", 
		p1s3t1 = "farming_super_radish_3.png", 
		p1s4t1 = "farming_super_radish_4.png", 
	},
	default_drop = {},
	drops = {
		p1s4t1 = {
			max_items = 4,
			items = {
				{ items = {'farming_super:seed_radish'} },
				{ items = {'farming_super:seed_radish'}, rarity = 2},
				{ items = {'farming_super:seed_radish'}, rarity = 5},
				{ items = {'farming_super:radish 4'} },
			}
		}, 
	},
	minlight = 10,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4, },
})


minetest.register_decoration({
	name = "farming_super:radish_4_1",
	deco_type = "simple",
	place_on = {"default:dirt_with_coniferous_litter",},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 4782,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"coniferous_forest", },
	y_max = 30,
	y_min = 1,
	decoration = "farming_super:radish_4_1",
	param2 = 3,
})


-- standard daikon
farming_super.register_plant("farming_super:daikon", {
	description = "Daikon",
	paramtype2 = "meshoptions",
	place_param2 = "V",
	inventory_image = "farming_super_seed_daikon.png",
-- 	visual_scale = 1.3,
	eat_value = 4,
	steps = {4}, -- phases, steps per tier 
	step_len = {1, 2, 2, 2},
	textures = { -- overrides default texture naming, allowing reuse
		p1s1t1 = "farming_super_green_pixels_1.png", 
		p1s2t1 = "farming_super_green_pixels_2.png", 
		p1s3t1 = "farming_super_daikon_3.png", 
		p1s4t1 = "farming_super_daikon_4.png", 
	},
	default_drop = {},
	drops = {
		p1s4t1 = {
			max_items = 4,
			items = {
				{ items = {'farming_super:seed_daikon'} },
				{ items = {'farming_super:seed_daikon'}, rarity = 2},
				{ items = {'farming_super:seed_daikon'}, rarity = 5},
				{ items = {'farming_super:daikon 4'} },
			}
		}, 
	},
	minlight = 10,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4, },
})


minetest.register_decoration({
	name = "farming_super:daikon_4_1",
	deco_type = "simple",
	place_on = {"default:dirt_with_jungle_litter",},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 7362,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"jungle", },
	y_max = 30,
	y_min = 1,
	decoration = "farming_super:daikon_4_1",
	param2 = 4,
})



-- standard beet
farming_super.register_plant("farming_super:beet", {
	description = "Beet",
	paramtype2 = "meshoptions",
	place_param2 = "#",
	inventory_image = "farming_super_seed_beet.png",
-- 	visual_scale = 1.3,
	eat_value = 2,
	steps = {4}, -- phases, steps per tier 
	step_len = {1, 2, 2, 2},
	textures = { -- overrides default texture naming, allowing reuse
		p1s1t1 = "farming_super_2x_green_pixels_1.png", 
		p1s2t1 = "farming_super_2x_green_pixels_2.png", 
		p1s3t1 = "farming_super_beet_3.png", 
		p1s4t1 = "farming_super_beet_4.png", 
	},
	default_drop = {},
	drops = {
		p1s4t1 = {
			max_items = 3,
			items = {
				{ items = {'farming_super:seed_beet'} },
				{ items = {'farming_super:seed_beet'}, rarity = 2},
				{ items = {'farming_super:seed_beet'}, rarity = 5},
				{ items = {'farming_super:beet 4'} },
			}
		}, 
	},
	minlight = 10,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4, },
})


minetest.register_decoration({
	name = "farming_super:beet_4_1",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass",},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 8421,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"grassland", },
	y_max = 70,
	y_min = 1,
	decoration = "farming_super:beet_4_1",
	param2 = 3,
})

-- standard carrot
farming_super.register_plant("farming_super:carrot", {
	description = "Carrot",
	paramtype2 = "meshoptions",
	place_param2 = "#",
	inventory_image = "farming_super_seed_carrot.png",
-- 	visual_scale = 1.3,
	eat_value = 2,
	steps = {4}, -- phases, steps per tier 
	step_len = {1, 2, 3, 3},
	textures = { -- overrides default texture naming, allowing reuse
		p1s1t1 = "farming_super_2x_green_pixels_1.png", 
		p1s2t1 = "farming_super_2x_green_pixels_2.png", 
		p1s3t1 = "farming_super_carrot_3.png", 
		p1s4t1 = "farming_super_carrot_4.png", 
	},
	default_drop = {},
	drops = {
		p1s4t1 = {
			max_items = 3,
			items = {
				{ items = {'farming_super:seed_carrot'} },
				{ items = {'farming_super:seed_carrot'}, rarity = 2},
				{ items = {'farming_super:seed_carrot'}, rarity = 5},
				{ items = {'farming_super:carrot 4'} },
			}
		}, 
	},
	minlight = 10,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4, },
})


minetest.register_decoration({
	name = "farming_super:carrot_4_1",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass",},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 2679,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"grassland", },
	y_max = 70,
	y_min = 1,
	decoration = "farming_super:carrot_4_1",
	param2 = 3,
})


-- standard carrot_red
farming_super.register_plant("farming_super:carrot_red", {
	description = "Carrot, Red",
	paramtype2 = "meshoptions",
	place_param2 = "#",
	inventory_image = "farming_super_seed_carrot.png",
-- 	visual_scale = 1.3,
	eat_value = 2,
	steps = {4}, -- phases, steps per tier 
	step_len = {1, 2, 3, 3},
	textures = { -- overrides default texture naming, allowing reuse
		p1s1t1 = "farming_super_2x_green_pixels_1.png", 
		p1s2t1 = "farming_super_2x_green_pixels_2.png", 
		p1s3t1 = "farming_super_carrot_3.png", 
		p1s4t1 = "farming_super_carrot_red_4.png", 
	},
	default_drop = {},
	drops = {
		p1s4t1 = {
			max_items = 3,
			items = {
				{ items = {'farming_super:seed_carrot_red'} },
				{ items = {'farming_super:seed_carrot_red'}, rarity = 2},
				{ items = {'farming_super:seed_carrot_red'}, rarity = 5},
				{ items = {'farming_super:carrot_red 4'} },
			}
		}, 
	},
	minlight = 10,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4, },
})


minetest.register_decoration({
	name = "farming_super:carrot_red_4_1",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass",},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 8432,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"grassland", },
	y_max = 70,
	y_min = 1,
	decoration = "farming_super:carrot_red_4_1",
	param2 = 3,
})


-- standard carrot_yellow
farming_super.register_plant("farming_super:carrot_yellow", {
	description = "Carrot, Yellow",
	paramtype2 = "meshoptions",
	place_param2 = "#",
	inventory_image = "farming_super_seed_carrot.png",
-- 	visual_scale = 1.3,
	eat_value = 2,
	steps = {4}, -- phases, steps per tier 
	step_len = {1, 2, 3, 3},
	textures = { -- overrides default texture naming, allowing reuse
		p1s1t1 = "farming_super_2x_green_pixels_1.png", 
		p1s2t1 = "farming_super_2x_green_pixels_2.png", 
		p1s3t1 = "farming_super_carrot_3.png", 
		p1s4t1 = "farming_super_carrot_yellow_4.png", 
	},
	default_drop = {},
	drops = {
		p1s4t1 = {
			max_items = 3,
			items = {
				{ items = {'farming_super:seed_carrot_yellow'} },
				{ items = {'farming_super:seed_carrot_yellow'}, rarity = 2},
				{ items = {'farming_super:seed_carrot_yellow'}, rarity = 5},
				{ items = {'farming_super:carrot_yellow 4'} },
			}
		}, 
	},
	minlight = 10,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4, },
})


minetest.register_decoration({
	name = "farming_super:carrot_yellow_4_1",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass",},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 1437,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"grassland", },
	y_max = 70,
	y_min = 1,
	decoration = "farming_super:carrot_yellow_4_1",
	param2 = 3,
})


-- standard carrot_purple
farming_super.register_plant("farming_super:carrot_purple", {
	description = "Carrot, Purple",
	paramtype2 = "meshoptions",
	place_param2 = "#",
	inventory_image = "farming_super_seed_carrot.png",
-- 	visual_scale = 1.3,
	eat_value = 2,
	steps = {4}, -- phases, steps per tier 
	step_len = {1, 2, 3, 3},
	textures = { -- overrides default texture naming, allowing reuse
		p1s1t1 = "farming_super_2x_green_pixels_1.png", 
		p1s2t1 = "farming_super_2x_green_pixels_2.png", 
		p1s3t1 = "farming_super_carrot_3.png", 
		p1s4t1 = "farming_super_carrot_purple_4.png", 
	},
	default_drop = {},
	drops = {
		p1s4t1 = {
			max_items = 3,
			items = {
				{ items = {'farming_super:seed_carrot_purple'} },
				{ items = {'farming_super:seed_carrot_purple'}, rarity = 2},
				{ items = {'farming_super:seed_carrot_purple'}, rarity = 5},
				{ items = {'farming_super:carrot_purple 4'} },
			}
		}, 
	},
	minlight = 10,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4, },
})


minetest.register_decoration({
	name = "farming_super:carrot_purple_4_1",
	deco_type = "simple",
	place_on = {"default:dirt_with_grass",},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 9978,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"grassland", },
	y_max = 70,
	y_min = 1,
	decoration = "farming_super:carrot_purple_4_1",
	param2 = 3,
})



-- rice
farming_super.register_plant("farming_super:rice", {
	description = "Rice",
	paramtype2 = "meshoptions",
	place_param2 = "#",
	inventory_image = "farming_super_seed_rice.png",
	default_drop = {},
	eat_value = 2,
-- 	visual_scale = 1.3,
	steps = {8}, -- phases, steps per tier 
	drops = {
		p1s8t1 = {
			max_items = 4,
			items = {
				{ items = {'farming_super:seed_rice 3'} },
				{ items = {'farming_super:seed_rice'}, rarity = 2},
				{ items = {'farming_super:seed_rice'}, rarity = 5},
			}
		}, 
	},
	minlight = 10,
	maxlight = 15,
	fertility = {"grassland"},
	groups = {flammable = 4, },
})

minetest.register_craft({
	output = "farming_super:rice",
	type = "cooking",
	recipe = "farming_super:seed_rice",
})


minetest.register_decoration({
	name = "farming_super:rice_8_1",
	deco_type = "simple",
	place_on = {"default:dirt_with_rainforest_litter",},
	sidelen = 16,
	noise_params = {
		offset = -0.0003,
		scale = 0.0009,
		spread = {x = 200, y = 200, z = 200},
		seed = 1365,
		octaves = 3,
		persist = 0.6
	},
	biomes = {"jungle",},
	y_max = 30,
	y_min = 1,
	decoration = "farming_super:rice_8_1",
	param2 = 0,
})




dofile(modpath.."/crafts.lua")

minetest.register_node("farming_super:test", {
	description = "Tester",
	drawtype = "plantlike",
-- 	waving = 1,
-- 	visual_scale = 1.69,
	tiles = {"farming_super_trellis.png"},
	inventory_image = "farming_super_test.png",
	paramtype = "light",
	paramtype2 = "meshoptions",
	sunlight_propagates = true,
-- 	walkable = false,
	buildable_to = false,
	grape_color = color,
	groups = {snappy = 2, plant=1, oddly_breakable_by_hand = 1, },
	sounds = default.node_sound_leaves_defaults(),
	selection_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.5, 4 / 16},
	},
	collision_box = {
		type = "fixed",
		fixed = {-4 / 16, -0.5, -4 / 16, 4 / 16, 0.5, 4 / 16},
	},
	place_param2 = 3,
})


