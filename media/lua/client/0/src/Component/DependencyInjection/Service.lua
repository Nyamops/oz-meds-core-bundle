OzMedsCoreBundle.Component.DependencyInjection.Service = {}
local Service = OzMedsCoreBundle.Component.DependencyInjection.Service

---@param T table
---@return Service
function Service:new(T)
    ---@class Service
    local public = {}
    ---Class namespace
    ---@type string
    public.className = T.className
    ---Class instance
    ---@type table
    public.instance = T.instance

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'OzMedsCoreBundle.Component.DependencyInjection.Service'

    return public
end