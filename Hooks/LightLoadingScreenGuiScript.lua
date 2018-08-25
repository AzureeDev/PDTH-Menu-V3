function LightLoadingScreenGuiScript:init(scene_gui, res, progress, base_layer, is_win32)
	self._base_layer = base_layer
	self._is_win32 = is_win32
	self._scene_gui = scene_gui
	self._res = res
	self._ws = scene_gui:create_screen_workspace()

	if _G.IS_VR then
		self._ws:set_pinned_screen(true)
	end

	self._safe_rect_pixels = self:get_safe_rect_pixels(res)
	self._saferect = self._scene_gui:create_screen_workspace()

	self:layout_saferect()

	local panel = self._ws:panel()
	self._panel = panel
	self._bg_gui = panel:rect({
		visible = true,
		color = Color.black,
		layer = base_layer
	})
	self._saferect_panel = self._saferect:panel()
	self._gui_tweak_data = {
		upper_saferect_border = 64,
		border_pad = 8
	}
    local menu_border_multiplier = 1
	local menu_logo_multiplier = 1
	local title_scale = 1
	if res.y <= 601 then
		title_scale = 0.7
		menu_border_multiplier = 0.6
		menu_logo_multiplier = 0.575
	end
	self._gui_tweak_data.upper_saferect_border = 64
	self._gui_tweak_data.border_pad = 8
	self._title_text = self._saferect_panel:text({
		y = 0,
		text = "",
		font = "fonts/font_large_mf",
		font_size = 32 * title_scale,
		color = Color.white,
		align = "left",
		halign = "left",
		vertical = "bottom",
		layer = self._base_layer + 1,
		h = 24
	})

    self._title_text:set_text(string.upper(" > " .. managers.localization:text("debug_loading_level")))

    self._stonecold_small_logo = self._saferect_panel:bitmap({
		texture = "guis/textures/game_small_logo",
		name = "stonecold_small_logo",
		h = 56,
		texture_rect = {
			0,
			0,
			256,
			56
		},
		layer = self._base_layer + 1
	})

    self._stonecold_small_logo:set_h(56)
    self._stonecold_small_logo:set_size(256 * menu_logo_multiplier, 56 * menu_logo_multiplier)

	self._indicator = self._saferect_panel:bitmap({
		texture = "guis/textures/icon_loading",
		name = "indicator",
		layer = self._base_layer + 1
	})
	self._dot_count = 0
	self._max_dot_count = 4
	self._init_progress = 0
	self._fake_progress = 0
	self._max_bar_width = 0

	self:setup(res, progress)
end

PDTHMenuV3:Post(LightLoadingScreenGuiScript, "layout_saferect", function(self)
    local scaled_size = {
		width = 1198,
		height = 674,
		x = 0,
		y = 0
	}

    local w = scaled_size.width
	local h = scaled_size.height
	local sh = math.min(self._safe_rect_pixels.height, self._safe_rect_pixels.width / (w / h))
	local sw = math.min(self._safe_rect_pixels.width, self._safe_rect_pixels.height * (w / h))
	local x = math.round(self._res.x / 2 - sh * (w / h) / 2)
	local y = math.round(self._res.y / 2 - sw / (w / h) / 2)
	self._saferect:set_screen(w, h, x, y, sw)
end)

function LightLoadingScreenGuiScript:layout_saferect()
    local scaled_size = {
		width = 1198,
		height = 674,
		x = 0,
		y = 0
	}

    local w = scaled_size.width
	local h = scaled_size.height
	local sh = math.min(self._safe_rect_pixels.height, self._safe_rect_pixels.width / (w / h))
	local sw = math.min(self._safe_rect_pixels.width, self._safe_rect_pixels.height * (w / h))
	local x = math.round(self._res.x / 2 - sh * (w / h) / 2)
	local y = math.round(self._res.y / 2 - sw / (w / h) / 2)
	self._saferect:set_screen(w, h, x, y, sw)
end

PDTHMenuV3:Post(LightLoadingScreenGuiScript, "setup", function(self, res, progress)
    self._title_text:set_font_size(32)
	local menu_border_multiplier = 1
	local menu_logo_multiplier = 1
	if res.y <= 601 then
		title_scale = 0.7
		menu_border_multiplier = 0.6
		menu_logo_multiplier = 0.575
	end
	self._stonecold_small_logo:set_size(256 * menu_logo_multiplier, 56 * menu_logo_multiplier)
	self._title_text:set_shape(0, 0, self._safe_rect_pixels.width, self._gui_tweak_data.upper_saferect_border - self._gui_tweak_data.border_pad )
	local _, _, w, _ = self._title_text:text_rect()
	self._title_text:set_w(w)
	self._stonecold_small_logo:set_right(self._stonecold_small_logo:parent():w() + 11)
	self._stonecold_small_logo:set_top(self._saferect_panel:top() - 8.5)
end)
