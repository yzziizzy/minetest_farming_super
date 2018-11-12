farming_super = {}


local modpath = minetest.get_modpath("farming_super")

dofile(modpath.."/api.lua")


-- todo: pests
-- todo: nutrient depletion



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

farming_super.register_plant("farming_super:corn", {
	description = "Corn",
	paramtype2 = "meshoptions",
	inventory_image = "farming_super_seed_corn.png",
	steps = {3, 1, 1, 2}, -- phases, steps per tier 
	default_drop = {},
	drops = {
		p4s2t2 = corndrop, -- phase 4, step 2, tier 2
		p4s2t3 = corndrop,
	},
	textures = { -- overrides default texture naming, allowing reuse
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
	groups = {flammable = 4},
	place_param2 = 2,
})







