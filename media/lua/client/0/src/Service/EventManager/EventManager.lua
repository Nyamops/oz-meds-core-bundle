OzMedsCoreBundle.Service.EventManager.EventManager = {}
local EventManager = OzMedsCoreBundle.Service.EventManager.EventManager

---@return EventManager
---@param logger Logger
function EventManager:new(logger)
    ---@class EventManager
    local public = {}
    local private = {}
    ---@type table<string, EventListener[]>
    private.listeners = {}
    ---@type Logger
    private.logger = logger

    ---Subscribe to event
    ---@param eventAlias string
    ---@param listener EventListener
    ---@return void
    function public:subscribe(eventAlias, listener)
        if private.listeners[eventAlias] == nil then
            private.listeners[eventAlias] = {}
        end

        private.logger:debug(
            string.format(
                'Added %s listener for %s event',
                getmetatable(listener),
                eventAlias
            )
        )
        table.insert(private.listeners[eventAlias], listener)
    end

    ---Unsubscribe from event
    ---@param eventAlias string
    ---@param listener EventListener
    ---@return void
    function public:unsubscribe(eventAlias, listener)
        for index, subscribedListener in ipairs(private.listeners[eventAlias]) do
            if getmetatable(subscribedListener) == getmetatable(listener) then
                private.logger:debug(
                    string.format(
                        'Removed %s listener for %s event',
                        getmetatable(listener),
                        eventAlias
                    )
                )
                table.remove(private.listeners, index)
            end
        end
    end

    ---Notify all listeners with data
    ---@param eventAlias string
    ---@param data table
    ---@return void
    function public:notify(eventAlias, data)
        if private.listeners[eventAlias] == nil then
            return
        end

        for _, listener in ipairs(private.listeners[eventAlias]) do
            private.logger:debug(
                string.format(
                    'Hit %s event. Call %s invoke() method',
                    eventAlias,
                    getmetatable(listener)
                )
            )
            listener:invoke(data)
        end
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'OzMedsCoreBundle.Service.EventManager.EventManager'

    return public
end