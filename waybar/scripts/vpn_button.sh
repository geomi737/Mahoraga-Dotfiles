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
        subprocess.run([ "sudo","awg-quick", "down", "/home/lesh/VPN/amnezia_for_awg.conf"], text=True)
    else:
        subprocess.run([ "sudo","awg-quick", "up", "/home/lesh/VPN/amnezia_for_awg.conf"], text=True)
