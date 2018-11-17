farming_super = {}


local modpath = minetest.get_modpath("farming_super")

dofile(modpath.."/api.lua")



--[[
TODO: crops

sugar beets
rice
oats
barley
beets
cabbage
sweet potatoes
peppers
onions
garlic
taro
radishes, daikon
broccoli
brussels sprouts
cauliflower
eggplant
beans
celery
ginger
colored carrots
okra
pineapple
peanuts
sunflower
lentils
hemp
sorghum


much later: 
	grapes
	hops
	lotus


TODO: features
corn oil processing
sugar processing


TODO: core
adjustable grow rates per step
pests
stick or strings for plants to grow on


drop-in replacement for farming_plus


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



