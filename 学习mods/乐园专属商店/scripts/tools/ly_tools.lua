--[[function table.removeItem( list,item,removeAll )
    local rmCount = 0
    for i = 1,#list do
        if list[i - rmCount] == item then
            table.remove(list,i - rmCount)
            if removeAll then
                rmCount = rmCount + 1
            else
                break
            end
        end
    end
end--]]



local function RemoveItemInTable(list,validfn)
	local k = 1
	while k <= #list do
		local v = list[k] 
		if validfn == nil or validfn(list,k,v) then
			table.remove(list,k)
		else
			k = k + 1
		end
	end
end

return {
	RemoveItemInTable = RemoveItemInTable,
}