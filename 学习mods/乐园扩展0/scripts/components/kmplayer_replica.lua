local json = require "json"
--local maxstring = 500
local maxlength = 5000
local sleeptime = 0.5
local kmplayer = Class(function(self, inst)
    self.inst = inst
    self.nextget = GetTime() -600
    self.goods = {}
    self.repl = {}
    self.goodsinfo = net_string(inst.GUID,"kmplayer.goodsinfo","kmgoodsdirty")
    self.goodjson = ""
    self._getgoods = false
    self._goods = net_int(inst.GUID,"kmplayer.change","kmplayerchangedirty")
    self:clientInit()
end
)

function kmplayer:clientInit()
    if not TheWorld.ismastersim and self.inst.GUID == ThePlayer.GUID  then
        self.inst:ListenForEvent("kmgoodsdirty",function(...) self:rec() end)
        SendModRPCToServer(GetModRPC("kmplayer", "getgoods"),-1,-1)
    end
    
    
end

function kmplayer:rec()
    local str = self.goodsinfo:value()
    if str == "begin" then
        print("客户端初始化开始")
        self.goodjson = ""
        self.goods = {}
    elseif str == "end" then
        --print("readend -> "..string.len(self.goodjson),"all -> "..self._goods:value())
        local j,goodsinfo = pcall(json.decode,self.goodjson)
        assert(j,"商品配置读取失败")
        self.goods = goodsinfo.goods
        self.repl = goodsinfo.repl
        self.goodjson = ""
        print("客户端初始化完成")
    else
        self.goodjson = self.goodjson..str
        --print("read -> "..string.len(self.goodjson))
    end
end

return kmplayer