OzMedsCoreBundle.ZCore = {}
---@type ZCore
local ZCore = OzMedsCoreBundle.ZCore

---@private
---@return ZCore
function ZCore:new()
    ---@class ZCore
    local public = {}
    local private = {}
    ---@type Container
    private.container = OzMedsCoreBundle.Component.DependencyInjection.Container:new()

    ---Get instance of Container
    ---@return Container
    function public:getContainer()
        return private.container
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'OzMedsCoreBundle.ZCore'

    return public
end

--use full namespace if class must be declared during boot
OzMedsCoreBundle.ZCore = OzMedsCoreBundle.ZCore:new()