require("util")

data:extend({ {
    type = "corpse",
    name = "heating-tower-remnants",
    icon = "__HeatingTower__/graphics/icons/heating-tower.png",
    flags = {"placeable-neutral", "not-on-map"},
    hidden_in_factoriopedia = true,
    subgroup = "energy-remnants",
    order = "c[heating-tower]",
    selection_box = {{-1.5, -1.5}, {1.5, 1.5}},
    tile_width = 3,
    tile_height = 3,
    selectable_in_game = false,
    time_before_removed = 60 * 60 * 15, -- 15 minutes
    expires = false,
    final_render_layer = "remnants",
    remove_on_tile_placement = false,
    animation = util.sprite_load("__HeatingTower__/graphics/entity/heating-tower/heating-tower-remnants",{
      scale = 0.5,
      direction_count = 1
    })
  }
})
