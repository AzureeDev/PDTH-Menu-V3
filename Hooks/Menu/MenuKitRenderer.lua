function MenuKitRenderer:show_node(node)
	local gui_class = MenuNodeKitGui

	if node:parameters().gui_class then
		gui_class = CoreSerialize.string_to_classtable(node:parameters().gui_class)
	end

    local parameters = {
		marker_alpha = 1,
		align = "left",
		row_item_blend_mode = "normal",
		to_upper = true,
		row_item_color = tweak_data.screen_colors.button_stage_3,
		row_item_hightlight_color = tweak_data.screen_colors.button_stage_2,
		font = tweak_data.menu.pd2_medium_font,
		font_size = tweak_data.menu.pd2_medium_font_size - 5,
		node_gui_class = gui_class,
		spacing = node:parameters().spacing,
		marker_color = tweak_data.screen_colors.button_stage_3:with_alpha(0.2)
	}

	MenuKitRenderer.super.super.show_node(self, node, parameters)
	self:_update_slots_info()
end
