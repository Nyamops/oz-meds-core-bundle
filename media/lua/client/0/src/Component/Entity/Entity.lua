OzMedsCoreBundle.Component.Entity.Entity = {}
local Entity = OzMedsCoreBundle.Component.Entity.Entity

---@param T table<string, any>
---@return Entity
function Entity:new(T)
    ---@class Entity
    local public = {
        name = T.name,
        description = T.description,
    }

    ---@return string
    function public:getName()
        return self.name
    end

    ---@return string
    function public:getDescription()
        return self.description
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'OzMedsCoreBundle.Component.Entity.Entity'

    return public
end