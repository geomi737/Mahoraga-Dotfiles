#!/usr/bin/env python3
import subprocess

def interface_exists(name):
    try:
        output = subprocess.check_output(['ip', 'link'], text=True)
        return any(line.strip().startswith(f"{name}:") or f": {name}:" in line for line in output.splitlines())
    except Exception:
        return False

if __name__ == "__main__":
    iface = "amnezia_for_awg"
    if interface_exists(iface):
        print(f'<span color="#82f88a">[ Hyprlink ON  ]</span>')
    else:
        print(f'<span color="#ff0000">[ Hyprlink OFF  ]</span>')