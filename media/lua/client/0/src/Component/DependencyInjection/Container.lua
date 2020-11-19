OzMedsCoreBundle.Component.DependencyInjection.Container = {}
local Container = OzMedsCoreBundle.Component.DependencyInjection.Container

---@return Container
function Container:new()
    ---@class Container
    local public = {}
    local private = {}
    ---@type table<string, Service>
    private.services = {}
    ---@type table<string, table<string, Service>>
    private.taggedServices = {}

    ---Register new class
    ---@param classObject table class to register
    ---@param arguments table parameters in constructor "new(...)"
    ---@param tag string tag for group classes
    ---@return void|nil
    ---@param className string class namespace
    function public:register(classObject, className, arguments, tag)
        ---@type Service
        local Service = OzMedsCoreBundle.Component.DependencyInjection.Service

        if private:has(className) then
            return nil
        end

        private.services[className] = Service:new {
            className = className,
            instance = classObject:new(unpack(arguments)),
        }

        if tag ~= nil then
            if private.taggedServices[tag] == nil then
                private.taggedServices[tag] = {}
            end
            private.taggedServices[tag][className] = private.services[className]
        end
    end

    ---Get registered class
    ---@param className string
    ---@return table|nil
    function public:get(className)
        if not private:has(className) then
            return nil
        end

        return private.services[className].instance
    end

    ---Get registered classes by tag
    ---@param tag string
    ---@return table<string, Service>
    function public:getByTag(tag)
        if private.taggedServices[tag] == nil then
            return {}
        end

        return private.services[tag].instance
    end

    ---Check for already registered class
    ---@return boolean
    ---@param className string class namespace
    function private:has(className)
        return private.services[className] ~= nil
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'OzMedsCoreBundle.Component.DependencyInjection.Container'

    return public
end