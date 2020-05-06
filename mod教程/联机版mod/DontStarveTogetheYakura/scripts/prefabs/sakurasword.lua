    local assets =     {         Asset("ANIM", "anim/sakurasword.zip"),         Asset("ANIM", "anim/swap_sakurasword.zip"),         Asset("IMAGE", "images/inventoryimages/sakurasword.tex"),         Asset("ATLAS", "images/inventoryimages/sakurasword.xml"),     }      local function onequip(inst, owner)         owner.AnimState:OverrideSymbol("swap_object", "swap_sakurasword", "sakurasword")         owner.AnimState:Show("ARM_carry")         owner.AnimState:Hide("ARM_normal")     end      local function onunequip(inst, owner)         owner.AnimState:Hide("ARM_carry")         owner.AnimState:Show("ARM_normal")     end  local function storeincontainer(inst, container)     if container ~= nil and container.components.container ~= nil then         inst:ListenForEvent("onputininventory", inst._oncontainerownerchanged, container)         inst:ListenForEvent("ondropped", inst._oncontainerownerchanged, container)         inst._container = container     end end  local function unstore(inst)     if inst._container ~= nil then         inst:RemoveEventCallback("onputininventory", inst._oncontainerownerchanged, inst._container)         inst:RemoveEventCallback("ondropped", inst._oncontainerownerchanged, inst._container)         inst._container = nil     end end  local function topocket(inst, owner)     if inst._container ~= owner then         unstore(inst)         storeincontainer(inst, owner)     end end  local function toground(inst)     unstore(inst) end      local function simple(name)         local inst = CreateEntity()          inst.entity:AddTransform()         inst.entity:AddAnimState()         inst.entity:AddNetwork()          MakeInventoryPhysics(inst)          inst.AnimState:SetBank(name)         inst.AnimState:SetBuild(name)         inst.AnimState:PlayAnimation("idle")          inst.entity:SetPristine()          if not TheWorld.ismastersim then             return inst         end          inst._container = nil              inst._oncontainerownerchanged = function(container)             topocket(inst, container)         end          inst._oncontainerremoved = function()             unstore(inst)         end                  inst:AddComponent("chosenowner")         inst.components.chosenowner:SetOwner("sakura")          inst:ListenForEvent("onputininventory", topocket)         inst:ListenForEvent("ondropped", toground)          inst:AddComponent("weapon")          inst:AddComponent("inspectable")          inst:AddComponent("inventoryitem")         inst.components.inventoryitem.atlasname = "images/inventoryimages/"..name..".xml"         inst.components.inventoryitem.imagename = name          inst:AddComponent("equippable")         inst.components.equippable:SetOnEquip(onequip)         inst.components.equippable:SetOnUnequip(onunequip)          MakeHauntableLaunch(inst)          return inst     end  local function sakura_func(inst, target)     local caster = inst.components.inventoryitem.owner     if not caster:HasTag("sakura") then         caster.components.health:DoDelta(-1)         caster:PushEvent("attacked", { attacker = caster, damage = 0 })         return     end     if target == nil then          if caster._fx == nil and inst.skillcd == nil then             inst.skillcd = GetTime() + TUNING.SAKURA_CD             STRINGS.CHARACTERS.GENERIC.DESCRIBE.SAKURASWORD= "技能冷却中\nSkill is cooling down."             inst.superstate = true             caster.components.hunger:DoDelta(-TUNING.SAKURA_SKILL_HUNGER)             caster.components.health:SetInvincible(true)             caster._fx = SpawnPrefab("forcefieldfx")             caster._fx.entity:SetParent(caster.entity)             caster._fx.AnimState:SetMultColour( 0, 0, 1, 1 )             caster._fx.Transform:SetPosition(0, 0.2, 0)             caster:DoTaskInTime(TUNING.SAKURA_SUPERTIME,function()                 inst.superstate = false                 if caster._fx ~= nil then                     caster._fx:kill_fx()                     caster._fx = nil                 end                 caster.components.health:SetInvincible(false)                 end)             inst:DoTaskInTime(TUNING.SAKURA_CD,function()                 inst.skillcd = nil                 STRINGS.CHARACTERS.GENERIC.DESCRIBE.SAKURASWORD= "技能准备完毕\nSkill ready."                 end)             local x,y,z = caster.Transform:GetWorldPosition()             local groundpound = SpawnPrefab("groundpoundring_fx")             groundpound.Transform:SetPosition(x,y,z)             local ents = TheSim:FindEntities(x, y, z, TUNING.SAKURA_RANGE, nil, {"player","companion","playerghost","abigail","wall"})             for k, v in pairs(ents) do                 if v.components.health ~= nil then                     if v.sakurafx == nil then                         v.sakurafx = SpawnPrefab("sakuramark")                         v.sakurafx.entity:SetParent(v.entity)                         v.sakurafx.Transform:SetPosition(0,1,0)                     end                     local sakurabomb = SpawnPrefab("sakurafx")                     local vx,vy,vz = v.Transform:GetWorldPosition()                     sakurabomb.Transform:SetPosition(vx,vy+1,vz)                     v.components.health:DoDelta(-TUNING.SAKURA_SKILL_DAMAGE)                     v:PushEvent("attacked", { attacker = caster, damage = 0 })                     caster.components.sanity:DoDelta(-TUNING.SAKURA_SKILL_SANITY)                 end             end         else             caster.components.talker:Say("技能冷却中\nSkill is cooling down.")         end     else          if target:HasTag("companion") or target:HasTag("sakura") then             caster.components.talker:Say(TUNING.SAKURA_DONT_ATTACK)             return         end         caster.Transform:SetPosition(target.Transform:GetWorldPosition())         if target.components.health == nil then return end         target.components.health:DoDelta(-TUNING.SAKURA_FLASH_DAMAGE)         target:PushEvent("attacked", { attacker = caster, damage = 0 })         if inst.superstate == true then              if target.sakuranum == nil then                 target.sakuranum = TUNING.SAKURA_FLASH_DELTA             else                 target.sakuranum = target.sakuranum + TUNING.SAKURA_FLASH_DELTA             end             if target.sakuranum >= 6 and target.sakurafx == nil then                 target.sakuranum = 0                 target.sakurafx = SpawnPrefab("sakuramark")                 target.sakurafx.entity:SetParent(target.entity)                 target.sakurafx.Transform:SetPosition(0,1,0)             end         end         if target.sakurafx ~= nil then             target.sakurafx:kill_fx()             target.sakurafx = nil             target.components.health:DoDelta(-target.components.health.maxhealth*TUNING.SAKURA_RATE, nil, nil, nil, nil, true)             target:PushEvent("attacked", { attacker = caster, damage = 0 })             local sakurabomb = SpawnPrefab("sakurafx")             local vx,vy,vz = target.Transform:GetWorldPosition()             sakurabomb.Transform:SetPosition(vx,vy+1,vz)         end     end end  local function OnSave(inst, data)     if inst.skillcd then         data.skillcd = inst.skillcd - GetTime()     end end  local function OnLoad(inst, data)     if data and data.skillcd then         STRINGS.CHARACTERS.GENERIC.DESCRIBE.SAKURASWORD= "技能冷却中\nSkill is cooling down."         inst.skillcd = data.skillcd + GetTime()         inst:DoTaskInTime(data.skillcd,function()             inst.skillcd = nil             STRINGS.CHARACTERS.GENERIC.DESCRIBE.SAKURASWORD= "技能准备完毕\nSkill ready."             end)     else         STRINGS.CHARACTERS.GENERIC.DESCRIBE.SAKURASWORD= "技能准备完毕\nSkill ready."     end end  local function fn()     local inst = simple("sakurasword")      if not TheWorld.ismastersim then         return inst     end     inst.superstate = false     inst.components.weapon:SetDamage(34)      inst:AddComponent("spellcaster")     inst.components.spellcaster:SetSpellFn(sakura_func)     inst.components.spellcaster.canuseontargets = true      inst.components.spellcaster.canonlyuseoncombat = true     inst.components.spellcaster.canusefrominventory = true      inst.components.spellcaster.canonlyuseonlocomotorspvp = true     inst.components.spellcaster.quickcast = true      inst.OnSave = OnSave     inst.OnLoad = OnLoad      return inst end return Prefab( "sakurasword", fn, assets)