local BORDER = '${--background3--}'

local FOREGROUND = '${--foreground--}'
local BACKGROUND = '${--background--}'

local TERM_BLACK = '${--terminal-black--}'
local TERM_RED = '${--terminal-red--}'
local TERM_GREEN = '${--terminal-green--}'
local TERM_YELLOW = '${--terminal-yellow--}'
local TERM_BLUE = '${--terminal-blue--}'
local TERM_MAGENTA = '${--terminal-magenta--}'
local TERM_CYAN = '${--terminal-cyan--}'
local TERM_WHITE = '${--terminal-white--}'

local TERM_BLACK_BRIGHT = '${--terminal-black-bright--}'
local TERM_RED_BRIGHT = '${--terminal-red-bright--}'
local TERM_GREEN_BRIGHT = '${--terminal-green-bright--}'
local TERM_YELLOW_BRIGHT = '${--terminal-yellow-bright--}'
local TERM_BLUE_BRIGHT = '${--terminal-blue-bright--}'
local TERM_MAGENTA_BRIGHT = '${--terminal-magenta-bright--}'
local TERM_CYAN_BRIGHT = '${--terminal-cyan-bright--}'
local TERM_WHITE_BRIGHT = '${--terminal-white-bright--}'

local module = {}

function module.apply(config)
    config.colors = {
        foreground = FOREGROUND,
        background = BACKGROUND,
        cursor_bg = FOREGROUND,
        cursor_fg = BACKGROUND,
        cursor_border = BORDER,
        selection_fg = BACKGROUND,
        selection_bg = FOREGROUND,
        scrollbar_thumb = BORDER,
        split = BORDER,
    }
    
    config.colors.ansi = {
        TERM_BLACK,
        TERM_RED,
        TERM_GREEN,
        TERM_YELLOW,
        TERM_BLUE,
        TERM_MAGENTA,
        TERM_CYAN,
        TERM_WHITE,
    }
    
    config.colors.brights = {
        TERM_BLACK_BRIGHT,
        TERM_RED_BRIGHT,
        TERM_GREEN_BRIGHT,
        TERM_YELLOW_BRIGHT,
        TERM_BLUE_BRIGHT,
        TERM_MAGENTA_BRIGHT,
        TERM_CYAN_BRIGHT,
        TERM_WHITE_BRIGHT,
    }
end

return module
