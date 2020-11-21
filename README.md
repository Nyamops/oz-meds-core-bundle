OZ Meds Core Bundle
===========

A [Project Zomboid](https://steamcommunity.com/sharedfiles/filedetails/?id=2289232090) bundle to manage dependencies.

**build41** support is done.

## Documentation

1. [Install](#installation)
1. [Basic usage](#basic-usage)
    1. [Container](#container)
    1. [Events](#events)
    1. [Logger](#logger)
    1. [Creating bundle](#creating-bundle)

## Installation

With [Steam workshop](https://steamcommunity.com/sharedfiles/filedetails/?id=2289232090) (recommended)

## Basic usage

### Container
This component implements a simple service container that allows you to standardize and centralize the way objects are constructed in your mod

Register a new service:
```lua
local Container = OzMedsCoreBundle.ZCore:getContainer()
local EventManager = OzMedsCoreBundle.Service.EventManager.EventManager
local Logger = OzMedsCoreBundle.Service.Logger.Logger

--Register a new service
Container:register(
    Logger, --Class object (table)
    'OzMedsCoreBundle.Service.Logger.Logger', --kind of namespace
    {} --arguments in constructor
)

--Register a new service with tag
Container:register(
    EventManager, --Class object (table)
    'OzMedsCoreBundle.Service.EventManager.EventManager', --kind of namespace
    { Container:get(getmetatable(Logger)) }, --arguments in constructor
    'tag' --tag
)
```

Get a service from container
```lua
--Get a service from a container by its alias
Container:get('OzMedsCoreBundle.Service.Logger.Logger')

--Get a services from a container by tag
Container:getByTag('tag')
```

### Events

#### Creating an Event
```lua
ISHealthPanelEvent = {}

---@return ISHealthPanelEvent
function OzMedsCoreBundle.Service.Event.ISHealthPanelEvent:new()
    local Container = OzMedsCoreBundle.ZCore:getContainer()

    ---@class ISHealthPanelEvent
    local public = {}
    public.eventManager = Container:get('OzMedsCoreBundle.Service.EventManager.EventManager') --make event manager public
    local private = {}
    private.doDrawItem = ISHealthPanel.doDrawItem --getting an instance of the method we will listen to
    private.update = ISHealthPanel.update --getting an instance of the method we will listen to

    function ISHealthPanel:doDrawItem(y, item, alt) --kind of decorator
        public.eventManager:notify('ISHealthPanel.doDrawItem', { self, y, item, alt }) --notify all listeners subscribed to ISHealthPanel.doDrawItem

        return private.doDrawItem(self, y, item, alt)
    end

    setmetatable(public, self)
    self.__index = self
    self.__metatable = 'OzMedsCoreBundle.Service.Event.ISHealthPanelEvent'

    return public
end

--instantiate after all files are initialized
Events.OnGameBoot.Add(
    function()
        local Container = OzMedsCoreBundle.ZCore:getContainer()
        local ISHealthPanelEvent = OzMedsCoreBundle.Service.Event.ISHealthPanelEvent
        Container:register(ISHealthPanelEvent, 'OzMedsCoreBundle.Service.Event.ISHealthPanelEvent', {})
    end
)
```

#### Creating an Event Listener

The most common way to listen to an event is to register an event listener:
```lua
--instantiate after a new game is started, or loading of a save is finished
Events.OnGameStart.Add(
    function()
        local Container = OzMedsCoreBundle.ZCore:getContainer()

        local eventListener = OzMedsCoreBundle.Service.EventListener.EventListener:new(
            function(data)
                local o = {}
                function o:doDrawItem(y, item, alt)
                    --...
                end
                --unpack table to methods arguments
                return o.doDrawItem(unpack(data))
            end
        )

        Container:get('OzMedsCoreBundle.Service.EventManager.EventManager'):subscribe(
            'ISHealthPanel.doDrawItem', --your event alias
            eventListener -- listener object with callback function
        )
    end
)
```

### Logger

#### Logging a Message
```lua
Logger:info('Just info')
Logger:error('An error occured')
Logger:critical('New build crashed my mod', { cause = 'shitcode' })
```

#### Where Logs are Stored

`{HOME_DIR}/Zomboid/console.txt`

### Creating bundle

The structure of a mod-bundle is meant to help to keep code consistent between all mods using OZ Core. It follows a set of conventions, but is flexible to be adjusted if needed

```lua
---Default namespace for the mod (media/lua/client/0/OzMedsCoreBundle.lua)
OzMedsCoreBundle = {
    Component = {
        DependencyInjection = {},
        Entity = {},
    },
    Helper = {},
    Service = {
        EventManager = {},
        EventListener = {},
        Logger = {},
    },
}
```

Highly recommended to use a "priority" directory after `media/lua/client/` or `media/lua/server/`
```text
#example
media/lua/client/0/src/Service/ZBootstrap.lua
```
