# See pudb/theme.py
# (https://github.com/inducer/pudb/blob/main/pudb/theme.py) to see what keys
# there are.

# Catppuccin Palette
rosewater = "h255"    #F5E0DC → h255 (#EEEEEE)
flamingo = "h224"     #F2CDCD → h224 (#FFD7D7)
pink = "h225"         #F5C2E7 → h225 (#FFD7FF)
pink_alt = "h218"     #F5C2E7 → h218 (#FFAFD7)
mauve = "h183"        #CBA6F7 → h183 (#D7AFFF)
red = "h211"          #F38BA8 → h211 (#FF87AF)
maroon = "h217"       #EBA0AC → h217 (#FFAFAF)
peach = "h216"        #FAB387 → h216 (#FFAF87)
yellow = "h223"       #F9E2AF → h223 (#FFD7AF)
green = "h151"        #A6E3A1 → h151 (#AFD7AF)
green_alt = "h151"    #A6E3A1 → h114 (#87D787)
teal = "h116"         #94E2D5 → h116 (#87D7D7)
sky = "h117"          #89DCEB → h117 (#87D7FF)
sky_alt = "h123"      #89DCEB → h123 (#87FFFF)
sapphire = "h117"     #74C7EC → h117 (#87D7FF)
blue = "h111"         #89B4FA → h111 (#87AFFF)
lavender = "h147"     #B4BEFE → h147 (#AFAFFF)
text = "h189"         #CDD6F4 → h189 (#D7D7FF)
subtext1 = "h146"     #BAC2DE → h146 (#AFAFD7)
subtext0 = "h146"     #A6ADC8 → h146 (#AFAFD7)
overlay2 = "h103"     #9399B2 → h103 (#8787AF)
overlay1 = "h103"     #7F849C → h103 (#8787AF)
overlay0 = "h60"      #6C7086 → h60  (#5F5F87)
overlay0_alt = "h243" #6C7086 → h243 (#767676)
surface2 = "h241"     #585B70 → h241 (#626262)
surface1 = "h239"     #45475A → h239 (#4E4E4E)
surface0 = "h237"     #313244 → h237 (#3A3A3A)
base = "h235"         #1E1E2E → h235 (#262626)
mantle = "h234"       #181825 → h234 (#1C1C1C)
crust = "h233"        #11111B → h233 (#121212)

magenta = "h201"      #FF00FF (debug)

link("current breakpoint", "current frame name")
link("focused current breakpoint", "focused current frame name")
palette_dict = {

    # {{{ base styles
    "background": (subtext1, mantle),
    "selectable": (text, crust),
    "focused selectable": (text, surface0),
    "highlighted": (base, yellow),
    "hotkey": (add_setting(subtext1, "underline"), surface0),
    # }}}

    # {{{ general ui
    # "label": "background",
    # "header": "background",
    "dialog title": (add_setting(base, "bold"), red),
    "group head": (add_setting(subtext1, "bold"), mantle),
    "focused sidebar": (subtext1, surface0),

    "input": (text, base),
    # "focused input": "focused selectable",
    "button": (add_setting(surface2, "bold"), base),
    "focused button": (add_setting(base, "bold"), green),
    # "value": "input",
    # "fixed value": "label",

    "warning": (add_setting(base, "bold"), red),
    # "header warning": "warning",
    # "search box": "focused input",
    # "search not found": "warning",
    # }}}

    # {{{ source view
    "source": (text, base),
    # "focused source": "focused selectable",
    # "highlighted source": "highlighted",

    "current source": (add_setting(surface0, "bold"), sapphire),
    # "current focused source": "focused source",
    # "current highlighted source": "current source",

    "breakpoint source": (add_setting(base, "bold"), red),
    # "breakpoint focused source": "focused source",
    # "current breakpoint source": "current source",
    # "current breakpoint focused source": "current focused source",

    "line number": (surface1, base),
    "breakpoint marker": (add_setting(red, "bold"), base),
    "current line marker": (add_setting(sky, "bold"), base),
    # }}}

    # {{{ sidebar
    # "sidebar one": "selectable",
    "sidebar two": (sky, crust),
    "sidebar three": (mauve, crust),

    # "focused sidebar one": "focused selectable",
    "focused sidebar two": (sky, surface0),
    "focused sidebar three": (mauve, surface0),
    # }}}

    # {{{ variables view
    # "variables": "selectable",
    "variable separator": (base, green),
    #
    # "var value": "sidebar one",
    # "var label": "sidebar two",
    # "focused var value": "focused sidebar one",
    # "focused var label": "focused sidebar two",

    "highlighted var label": (surface0, sapphire),
    # "highlighted var value": "highlighted",
    # "focused highlighted var label": "focused var label",
    # "focused highlighted var value": "focused var value",

    "return label": (green, mantle),
    # "return value": "var value",
    "focused return label": (green, surface0),
    # "focused return value": "focused var value",
    # }}}

    # {{{ stack
    # "stack": "selectable",
    #
    # "frame name": "sidebar one",
    # "frame class": "sidebar two",
    # "frame location": "sidebar three",
    #
    # "focused frame name": "focused sidebar one",
    # "focused frame class": "focused sidebar two",
    # "focused frame location": "focused sidebar three",

    "current frame name": (green, crust),
    # "current frame class": "frame class",
    # "current frame location": "frame location",

    "focused current frame name": (green, surface0),
    # "focused current frame class": "focused frame class",
    # "focused current frame location": "focused frame location",
    # }}}

    # {{{ breakpoints view
    # "breakpoint": "sidebar two",
    # "disabled breakpoint": "sidebar three",
    # "current breakpoint": "breakpoint",
    # "disabled current breakpoint": "disabled breakpoint",
    #
    # "focused breakpoint": "focused sidebar two",
    # "focused current breakpoint": "focused breakpoint",
    # "focused disabled breakpoint": "focused sidebar three",
    # "focused disabled current breakpoint": "focused disabled breakpoint",
    # }}}

    # {{{ shell
    # "command line edit": "source",
    "command line output": (sky, base),
    "command line prompt": (add_setting(yellow, "bold"), base),
    # "command line input": "source",
    "command line error": (red, base),

    "focused command line output": (sky, surface0),
    # "focused command line input": "focused source",
    "focused command line error": (add_setting(red, "bold"), surface0),

    # "command line clear button": "button",
    # "command line focused button": "focused button",
    # }}}

    # {{{ Code syntax
    "comment":     (surface1, base),
    "keyword":     (mauve, base), # "from", "and", "break", "is", "try", "True", "None", etc.
    "literal":     (green, base),
    # "name":         "source",
    "operator":    (text, base), # "+", "-", "=" etc.
    "punctuation": (red, base),
    "argument":    (red, base), # Function arguments
    "builtin":     (yellow, base), # "range", "dict", "set", "list", etc.
    "exception":   (yellow, base), # Exception names
    "function":    (blue, base),
    "pseudo":      (red, base), # "self", "cls"
    "class":       (add_setting(yellow, "underline"), base),
    "dunder":      (sky, base), # Class method names of the form __<name>__
    "magic":       (peach, base), # Special dunders like "__str__", "__init__", etc.
    "namespace":   (blue, base), # "import", "from", "using"
    "keyword2":    (mauve, base), # "class", "def", "exec", "lambda", "print"
    # "string":       "literal",
    # "doublestring": "string",
    # "singlestring": "string",
    "docstring":   (green, base),
    # "backtick":     "string",
    # }}}
}

palette.update(palette_dict)
