--- @sync entry

local function hide_preview_layout(self)
	local all = MANAGER.ratio.parent + MANAGER.ratio.current
	self._chunks = ui.Layout()
		:direction(ui.Layout.HORIZONTAL)
		:constraints({
			ui.Constraint.Ratio(MANAGER.ratio.parent, all),
			ui.Constraint.Ratio(MANAGER.ratio.current, all),
			ui.Constraint.Length(1),
		})
		:split(self._area)
end

local function max_preview_layout(self)
	self._chunks = ui.Layout()
		:direction(ui.Layout.HORIZONTAL)
		:constraints({
			ui.Constraint.Percentage(0),
			ui.Constraint.Percentage(0),
			ui.Constraint.Percentage(100),
		})
		:split(self._area)
end

local function entry(st)
	if st.old then
		if st.mode == 'max' then
			st.mode = 'hide'
			Tab.layout = hide_preview_layout
		elseif st.mode == 'hide' then
			Tab.layout, st.old = st.old, nil
		end
	else
		st.old = Tab.layout
		st.mode = 'max'
		Tab.layout = max_preview_layout
	end
	ya.app_emit("resize", {})
end

local function enabled(st) return st.old ~= nil end

return { entry = entry, enabled = enabled }
