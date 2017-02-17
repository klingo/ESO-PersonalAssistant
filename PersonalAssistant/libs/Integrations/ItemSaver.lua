-- Integration module
-- Addon: Item Saver
-- Author: ingeniousclown, Randactyl
-- Link: http://www.esoui.com/downloads/info300-ItemSaver.html#info

-- TODO: Replace with http://www.esoui.com/downloads/info630-FCOItemSaver.html#info

ItemSaver = {}

function ItemSaver.isItemSaved(bagId, slotIndex)
	local isItemSaverEnabled, isItemSaved = pcall(ItemSaver_IsItemSaved, bagId, slotIndex)
	if (not isItemSaverEnabled or isItemSaved == nil) then
		return false
	end
	return isItemSaved
end