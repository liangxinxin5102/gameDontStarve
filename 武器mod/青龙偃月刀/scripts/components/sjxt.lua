local sjxt = Class(function(self, inst)
    self.inst = inst
    self.level = 0
end)

function sjxt:OnSave()
    local data = {
        level = self.level,
    }
    return data
end

function sjxt:OnLoad(data)
    self.level = data.level or 0
end

function sjxt:DoDeltalevel(delta)
    --self.youshanon = self.youshanon + delta
    --self.inst:PushEvent("DoDeltaYoushan")
end

return sjxt