OzMedsCoreBundle.Service.EventListener.EventListener = {}
local EventListener = OzMedsCoreBundle.Service.EventListener.EventListener

---@param callback fun(data:table): void
---@return EventListener
function EventListener:new(callback)
    ---@class EventListener
    local public = {}
    local private = {}
    private.callback = callback

    ---Invoke subscribers logic
    ---@param data table
    ---@return void
    function public:invoke(data)
        return private.callback(data)
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = uniqid()

    return public
end