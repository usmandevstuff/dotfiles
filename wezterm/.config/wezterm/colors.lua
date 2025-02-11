local BORDER = '#303030'

local FOREGROUND = '#ebdbb2'
local BACKGROUND = '#1d2021'

local TERM_BLACK = '#323536'
local TERM_RED = '#cc241d'
local TERM_GREEN = '#98971a'
local TERM_YELLOW = '#d79921'
local TERM_BLUE = '#458588'
local TERM_MAGENTA = '#b16286'
local TERM_CYAN = '#689d6a'
local TERM_WHITE = '#ebdbb2'

local TERM_BLACK_BRIGHT = '#444748'
local TERM_RED_BRIGHT = '#fb4934'
local TERM_GREEN_BRIGHT = '#b8bb26'
local TERM_YELLOW_BRIGHT = '#fabd2f'
local TERM_BLUE_BRIGHT = '#83a598'
local TERM_MAGENTA_BRIGHT = '#d3869b'
local TERM_CYAN_BRIGHT = '#8ec07c'
local TERM_WHITE_BRIGHT = '#fbf1c7'

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
