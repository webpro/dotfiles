ext.frame = {}

function ext.frame.push(screen, direction)
    local frames = {
        [ "m" ] = function()
            return {
                x = screen.x,
                y = screen.y,
                w = screen.w,
                h = screen.h
            }
        end,

        [ "up" ] = function()
            return {
                x = screen.x,
                y = screen.y,
                w = screen.w,
                h = screen.h / 2
            }
        end,

        [ "down" ] = function()
            return {
                x = screen.x,
                y = screen.h / 2,
                w = screen.w,
                h = screen.h / 2
            }
        end,

        [ "left" ] = function()
            return {
                x = screen.x,
                y = screen.y,
                w = screen.w / 2,
                h = screen.h
            }
        end,

        [ "right" ] = function()
            return {
                x = screen.w / 2,
                y = screen.y,
                w = screen.w / 2,
                h = screen.h
            }
        end
    }

    return frames[direction]()
end

function setframe(direction)
    return function()
        local win = window.focusedwindow()
        local screen = win:screen():frame_without_dock_or_menu()
        local frame = ext.frame.push(screen, direction)
        win:setframe(frame)
    end
end

local mash = {"ctrl", "alt", "cmd"}

fnutils.each({ "m", "up", "down", "left", "right" }, function(direction)
    hotkey.bind(mash, direction, setframe(direction))
end)
