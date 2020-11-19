OzMedsCoreBundle.Service.ZBootstrap = {}
---@type ZBootstrap
local ZBootstrap = OzMedsCoreBundle.Service.ZBootstrap

---@private
---@return ZBootstrap
function ZBootstrap:new()
    --import
    ---@type Logger
    local Logger = OzMedsCoreBundle.Service.Logger.Logger
    ---@type EventManager
    local EventManager = OzMedsCoreBundle.Service.EventManager.EventManager
    --import

    ---@class ZBootstrap
    local public = {}
    local private = {}
    ---@type Container
    private.container = OzMedsCoreBundle.ZCore:getContainer()

    private.container:register(Logger, 'OzMedsCoreBundle.Service.Logger.Logger', {})
    private.container:register(
        EventManager,
        'OzMedsCoreBundle.Service.EventManager.EventManager',
        {
            private.container:get('OzMedsCoreBundle.Service.Logger.Logger')
        }
    )

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'OzMedsCoreBundle.Service.ZBootstrap'

    ---@type Logger
    local logger = private.container:get('OzMedsCoreBundle.Service.Logger.Logger')
    logger:info('OZ Meds Core Bundle successfully loaded!')

    return public
end

--Load bootstrap after all files are initialized
Events.OnGameBoot.Add(
    function()
        --no need to store this class in a container
        OzMedsCoreBundle.Service.ZBootstrap = OzMedsCoreBundle.Service.ZBootstrap:new()
    end
)
