OzMedsCoreBundle.Service.Logger.Logger = {
    DEBUG = 100,
    INFO = 200,
    NOTICE = 250,
    WARNING = 300,
    ERROR = 400,
    CRITICAL = 500,
    ALERT = 550,
    EMERGENCY = 600,
}
---@type Logger
local Logger = OzMedsCoreBundle.Service.Logger.Logger

---@return Logger
function Logger:new()
    --import
    ---@type LoggerAbstract
    local LoggerAbstract = OzMedsCoreBundle.Service.Logger.LoggerAbstract
    --import

    ---@class Logger : LoggerAbstract
    local public = {}
    local private = {
        levels = {
            { value = Logger.DEBUG, alias = 'DEBUG' },
            { value = Logger.INFO, alias = 'INFO' },
            { value = Logger.NOTICE, alias = 'NOTICE' },
            { value = Logger.WARNING, alias = 'WARNING' },
            { value = Logger.ERROR, alias = 'ERROR' },
            { value = Logger.CRITICAL, alias = 'CRITICAL' },
            { value = Logger.ALERT, alias = 'ALERT' },
            { value = Logger.EMERGENCY, alias = 'EMERGENCY' },
        }
    }

    ---@param level number
    ---@return string
    function private:toLoggerLevel(level)
        for _, v in pairs(private.levels) do
            if v.value == level then
                return v.alias
            end
        end
    end

    ---@param level string
    ---@param message string
    ---@param context table|nil
    function public:log(level, message, context)
        if level >= self.DEBUG then
            local loggerLevel = private:toLoggerLevel(level)
            print(
                string.format(
                    '[%s] %s: (OzMeds) %s',
                    os.date('%H:%M:%S'),
                    loggerLevel,
                    message
                )
            )

            if context ~= nil then
                var_dump(context)
            end
        end
    end

    setmetatable(public, self)
    self.__index = LoggerAbstract.new(self)
    self.__metatable = 'OzMedsCoreBundle.Service.Logger.Logger'

    return public
end