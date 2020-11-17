OzMedsCoreBundle.Service.Logger.LoggerAbstract = {}
---@type LoggerAbstract
local LoggerAbstract = OzMedsCoreBundle.Service.Logger.LoggerAbstract

---@private
function LoggerAbstract:new()
    ---@class LoggerAbstract
    local public = {}

    ---@param message string
    ---@param context table|nil
    function public:debug(message, context)
        ---@type Logger
        local Logger = OzMedsCoreBundle.Service.Logger.Logger
        return self:log(Logger.DEBUG, message, context)
    end

    ---@param message string
    ---@param context table|nil
    function public:info(message, context)
        ---@type Logger
        local Logger = OzMedsCoreBundle.Service.Logger.Logger
        return self:log(Logger.INFO, message, context)
    end

    ---@param message string
    ---@param context table|nil
    function public:notice(message, context)
        ---@type Logger
        local Logger = OzMedsCoreBundle.Service.Logger.Logger
        return self:log(Logger.NOTICE, message, context)
    end

    ---@param message string
    ---@param context table|nil
    function public:warning(message, context)
        ---@type Logger
        local Logger = OzMedsCoreBundle.Service.Logger.Logger
        return self:log(Logger.WARNING, message, context)
    end

    ---@param message string
    ---@param context table|nil
    function public:error(message, context)
        ---@type Logger
        local Logger = OzMedsCoreBundle.Service.Logger.Logger
        return self:log(Logger.ERROR, message, context)
    end

    ---@param message string
    ---@param context table|nil
    function public:critical(message, context)
        ---@type Logger
        local Logger = OzMedsCoreBundle.Service.Logger.Logger
        return self:log(Logger.CRITICAL, message, context)
    end

    ---@param message string
    ---@param context table|nil
    function public:alert(message, context)
        ---@type Logger
        local Logger = OzMedsCoreBundle.Service.Logger.Logger
        return self:log(Logger.ALERT, message, context)
    end

    ---@param message string
    ---@param context table|nil
    function public:emergency(message, context)
        ---@type Logger
        local Logger = OzMedsCoreBundle.Service.Logger.Logger
        return self:log(Logger.EMERGENCY, message, context)
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'OzMedsCoreBundle.Service.Logger.LoggerAbstract'

    return public
end