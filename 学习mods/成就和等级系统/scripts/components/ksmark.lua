local ksmark = Class(function(self, inst)
    self.inst = inst
    self.mark = false
end)

function ksmark:OnSave()
    local data = {
        mark = self.mark,
    }
    return data
end

function ksmark:OnLoad(data)
    self.mark = data.mark or false
end

return ksmark