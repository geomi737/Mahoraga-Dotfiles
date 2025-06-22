#!/usr/bin/env python3
import subprocess
import re

def get_volume(mute):
    if mute == "false":
        try:
            out = subprocess.check_output(['wpctl', 'get-volume', '@DEFAULT_AUDIO_SINK@'], text=True)
            match = re.search(r'Volume: ([0-9.]+)', out)
            return int(float(match.group(1)) * 100) if match else 0
        except Exception:
            return 0
    else:
        return 0    

def get_mute():
    try:
        out = subprocess.check_output(['wpctl', 'get-volume', '@DEFAULT_AUDIO_SINK@'], text=True)
        return "true" if "[MUTED]" in out else "false"
    except Exception:
        return "false"

def make_bar(percent):
    filled = (percent + 5) // 10
    empty = 10 - filled
    return '█' * filled + '░' * empty

def get_color(vol, mute):
    if mute == "false":
        if vol == 0 or vol == 100:
            return "#ff5555"
        elif vol < 20:
            return "#f1fa8c"
        else:
            return "#ffffff"
    else:
        return "#ff5555"

if __name__ == '__main__':
    mute = get_mute()
    vol = get_volume(mute)
    bar = make_bar(vol)
    color = get_color(vol, mute)
    print(f'<span color="{color}">   [{bar}] {vol}%</span>')
