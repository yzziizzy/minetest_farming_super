


minetest.register_craftitem("farming_super:rice_bag", {
	description = "Rice Bag",
	inventory_image = "farming_super_rice_bag.png",
	groups = {},
})


minetest.register_craft({
	output = "farming_super:rice_bag 1",
	recipe = {
		{"farming_super:seed_rice","farming_super:seed_rice","farming_super:seed_rice"},
		{"farming_super:seed_rice","farming_super:seed_rice","farming_super:seed_rice"},
		{"farming_super:seed_rice","farming_super:seed_rice","farming_super:seed_rice"},
	}
})


minetest.register_craft({
	output = "farming_super:seed_rice 9",
	type = "shapeless",
	recipe = {"farming_super:rice_bag"},
})

