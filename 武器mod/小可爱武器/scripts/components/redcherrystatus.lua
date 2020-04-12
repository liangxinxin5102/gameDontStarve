local redcherrystatus = Class(function(self, inst)
    self.inst = inst
    self.level = 0
end)

function redcherrystatus:OnSave()
    local data = {
        level = self.level,
    }
    return data
end

function redcherrystatus:OnLoad(data)
    self.level = data.level or 0
end

function redcherrystatus:DoDeltalevel(delta)
    --self.youshanon = self.youshanon + delta
    --self.inst:PushEvent("DoDeltaYoushan")
end

return redcherrystatus