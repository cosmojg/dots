#!/usr/bin/env python
"""
Convert colors from 24-bit #HEXADECIMAL or R G B to 8-bit xterm h256

"""

import doctest
import sys
from colortrans import rgb2short, short2rgb
from colortrans_hsv import rgb2short as rgb2short_hsv
from colortrans_hsv import short2rgb as short2rgb_hsv

def rgb_to_xterm_perceptually_uniform(r, g, b) -> int:
    """
    Convert RGB24 to xterm-256 8-bit value
    For simplicity, assume RGB space is perceptually uniform.
    There are 5 places where one of two outputs needs to be chosen when the
    input is the exact middle:
    - The r/g/b channels and the gray value: the higher value output is chosen.
    - If the gray and color have same distance from the input - color is chosen.

    Acknowledgements:
    [1] https://stackoverflow.com/a/41978310/6292397 (@avih)
    [2] https://github.com/tmux/tmux/pull/432 (@avih)
    """

    # Calculate the nearest 0-based color index at 16 .. 231
    def v2ci(v):
        return 0 if v < 48 else 1 if v < 115 else (v - 35) // 40

    ir, ig, ib = v2ci(r), v2ci(g), v2ci(b) # 0..5 each

    def color_index():
        return 36 * ir + 6 * ig + ib # 0..215, lazy evaluation

    # Calculate the nearest 0-based gray index at 232 .. 255
    average = (r + g + b) // 3
    gray_index = 23 if average > 238 else (average - 3) // 10 # 0..23

    # Calculate the represented colors back from the index
    i2cv = [0, 0x5f, 0x87, 0xaf, 0xd7, 0xff]
    cr, cg, cb = i2cv[ir], i2cv[ig], i2cv[ib] # r/g/b, 0..255 each
    gv = 8 + 10 * gray_index # same value for r/g/b, 0..255

    # Return the one which is nearer to the original input rgb value
    def dist_square(A, B, C, a, b, c):
        return (A - a) * (A - a) + (B - b) * (B - b) + (C - c) * (C - c)

    color_err = dist_square(cr, cg, cb, r, g, b)
    gray_err = dist_square(gv, gv, gv, r, g, b)
    return 16 + color_index() if color_err <= gray_err else 232 + gray_index

N = []
for i, n in enumerate([47, 68, 40, 40, 40, 21]):
    N.extend([i]*n)

def rgb_to_xterm_constant_time(r, g, b) -> int:
    """
    Acknowledgements:
    [1] https://stackoverflow.com/a/62219320/6292397 (@sheerun)
    """
    mx = max(r, g, b)
    mn = min(r, g, b)

    if (mx-mn)*(mx+mn) <= 6250:
        c = 24 - (252 - ((r+g+b) // 3)) // 10
        if 0 <= c <= 23:
            return 232 + c

    return 16 + 36*N[r] + 6*N[g] + N[b]

def print_all(hex, r, g, b):
    # print(f"\033[38;2;{r};{g};{b}m#HEXDEC = #{hex.upper()}\033[0m\n")
    # print(f"\033[38;2;{r};{g};{b}mR, G, B = {r, g, b}\033[0m\n")
    old = rgb_to_xterm_perceptually_uniform(r, g, b)
    new = rgb_to_xterm_constant_time(r, g, b)
    short, rgb = rgb2short(hex)
    short_hsv, rgb_hsv = rgb2short_hsv(hex)
    print(f"algo1: \033[38;2;{r};{g};{b}mrgb{r, g, b} (#{hex.upper()})"
          f"\033[0m → \033[38;5;{old}mh{str(old).ljust(3, ' ')} (#{short2rgb(str(old)).upper()})"
          f"\033[0m ∷ \033[38;2;{r};{g};{b}m█████████\033[38;5;{old}m█████████\033[0m")
    print(f"algo2: \033[38;2;{r};{g};{b}mrgb{r, g, b} (#{hex.upper()})"
          f"\033[0m → \033[38;5;{new}mh{str(new).ljust(3, ' ')} (#{short2rgb(str(new)).upper()})"
          f"\033[0m ∷ \033[38;2;{r};{g};{b}m█████████\033[38;5;{new}m█████████\033[0m")
    print(f"algo3: \033[38;2;{r};{g};{b}mrgb{r, g, b} (#{hex.upper()})"
          f"\033[0m → \033[38;5;{short}mh{str(short).ljust(3, ' ')} (#{rgb.upper()})"
          f"\033[0m ∷ \033[38;2;{r};{g};{b}m█████████\033[38;5;{short}m█████████\033[0m")
    print(f"algo4: \033[38;2;{r};{g};{b}mrgb{r, g, b} (#{hex.upper()})"
          f"\033[0m → \033[38;5;{short_hsv}mh{str(short_hsv).ljust(3, ' ')} (#{rgb_hsv.upper()})"
          f"\033[0m ∷ \033[38;2;{r};{g};{b}m█████████\033[38;5;{short_hsv}m█████████\033[0m")

if __name__ == '__main__':
    if len(sys.argv) == 4:
        r, g, b = (int(x) for x in sys.argv[1:])
        hex = '{:02x}{:02x}{:02x}'.format(r, g, b)
        print_all(hex, r, g, b)
    elif len(sys.argv) == 2:
        hex = sys.argv[1].strip('#')
        r, g, b = int(hex[0:2], 16), int(hex[2:4], 16), int(hex[4:6], 16)
        print_all(hex, r, g, b)
    elif len(sys.argv) == 1:
        for r in range(256):
            for g in range(256):
                for b in range(256):
                    hex = '{:02x}{:02x}{:02x}'.format(r, g, b)
                    old = rgb_to_xterm_perceptually_uniform(r, g, b)
                    new = rgb_to_xterm_constant_time(r, g, b)
                    short, rgb = rgb2short(hex)
                    short_hsv, rgb_hsv = rgb2short_hsv(hex)
                    if abs(old - new) > 1 and abs(int(short) - int(short_hsv)) > 1 and abs(old - int(short)) > 1 and abs(old - int(short_hsv)) > 1 and abs(int(short) - new) > 1 and abs(int(short_hsv) - new) > 1:
                        print_all(hex, r, g, b)
        print("Done.")
    else:
        raise SystemExit
